import 'dart:collection';

import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

import '../mapper_config.dart';
import '../models/RefChain.dart';
import '../models/source_assignment.dart';
import 'assignment_builder.dart';
import 'parameter_copy.dart';

/// Generates the implemented mapper method by the given abstract [MethodElement].
Method buildMapperImplementation(
    Map<String, dynamic> config, MethodElement method, ClassElement abstractMapper) {
  if (method.returnType.element == null) {
    throw InvalidGenerationSourceError('${method.returnType} is not a valid return type',
        element: method, todo: 'Add valid return type to mapping method');
  }
  return Method((b) => b
    ..annotations.add(CodeExpression(Code('override')))
    ..name = method.displayName
    ..requiredParameters.addAll(method.parameters.map((e) => copyParameter(e)))
    ..body = _generateBody(config, method, abstractMapper)
    ..returns = refer(method.returnType.getDisplayString(withNullability: true)));
}

/// Generates the implemented mapper method by the given abstract [MethodElement].
Method buildStaticMapperImplementation(
    Map<String, dynamic> config, MethodElement method, ClassElement abstractMapper) {
  return Method(
    (b) => b
      ..name = '_\$${method.name}'
      ..requiredParameters.addAll(method.parameters.map((e) => copyParameter(e)))
      ..body = _generateBody(config, method, abstractMapper)
      ..returns = refer(method.returnType.getDisplayString(withNullability: true)),
  );
}

/// Generates the body for the mapping method.
///
/// Uses the default constructor of the target mapping class to populate optional and required named and positional parameters.
/// If the target class has any properties which were not set in the constructor, and are mappable by the source, they will be also mapped after initializing the target instance.
Code _generateBody(Map<String, dynamic> config, MethodElement method, ClassElement abstractMapper) {
  final blockBuilder = BlockBuilder();

  final targetClass = method.returnType.element as ClassElement;

  final sourceParams = method.parameters;

  final _ = _targetToSource(sourceParams, targetClass, method, config);
  final targetToSource = _[0];
  // final customTargetToSource = _[1];

  final targetConstructor = _chooseConstructor(targetClass);
  final positionalArgs = <Expression>[];
  final namedArgs = <String, Expression>{};

  // fills namedArgs and positionalArgs for the targetConstructor if
  // one of the inputfields matches the current constructorfield
  targetConstructor.parameters
      .where((targetField) => targetToSource.containsKey(targetField.name))
      .forEach((targetField) {
    final sourceAssignment = targetToSource[targetField.name]!;
    var sourceFieldAssignment =
        generateSourceFieldAssignment(sourceAssignment, abstractMapper, targetField);
    if (targetField.isNamed) {
      namedArgs.putIfAbsent(targetField.name, () => sourceFieldAssignment);
    } else {
      positionalArgs.add(sourceFieldAssignment);
    }
    targetToSource.remove(targetField.name);
  });

  var targetVarName = targetClass.displayName.toLowerCase();

  // source.isOptional does not work
  for (final sourceParam in sourceParams) {
    if (sourceParam.type.getDisplayString(withNullability: true).endsWith('?')) {
      if (!(sourceParam.type.element as ClassElement).isAbstract) {
        blockBuilder
            .addExpression(refer('if (${sourceParam.displayName} == null) { return null; }'));
      }
    }
  }

  // final output = Output(positionalArgs, {namedArgs});
  blockBuilder.addExpression(declareFinal(targetVarName)
      .assign(refer(targetConstructor.displayName).newInstance(positionalArgs, namedArgs)));

  // non final properties (implicit and explicit setters)
  final fields = _findFields(targetClass);
  fields //
      .where((field) => !field.isFinal) //
      .where((targetField) => targetToSource.containsKey(targetField.displayName))
      .map((targetField) {
    var sourceAssignment = targetToSource[targetField.displayName]!;
    var sourceFieldAssignment =
        generateSourceFieldAssignment(sourceAssignment, abstractMapper, targetField);
    return refer(targetVarName).property(targetField.displayName).assign(sourceFieldAssignment);
  }).forEach((expr) => blockBuilder.addExpression(expr));

  blockBuilder.addExpression(refer(targetVarName).returned);
  return blockBuilder.build();
}

/// Chooses the constructor which will be used to instantiate the target class.
ConstructorElement _chooseConstructor(ClassElement outputClass) {
  ConstructorElement chosen = outputClass.constructors.where((element) => !element.isFactory).first;
  for (var con in outputClass.constructors) {
    if (con.parameters.length >= chosen.parameters.length) {
      // choose the one with the most parameters
      chosen = con;
    }
  }
  return chosen;
}

List<FieldElement> _findFields(ClassElement clazz) {
  final allSuperclasses = clazz.allSupertypes
      .map((e) => e.element)
      .where((element) => !element.isDartCoreObject)
      .toList();

  final allAccessors = allSuperclasses.map((e) => e.accessors).expand((e) => e);
  final accessorMap = {for (var e in allAccessors) e.displayName: e};

  // ignore: prefer_function_declarations_over_variables
  final fieldFilter = (FieldElement field) {
    var isAbstract = false;
    // fields, who can also be getters, are never abstract, only their PropertyAccessorElement (implicit getter)
    if (accessorMap.containsKey(field.displayName)) {
      final accessor = accessorMap[field.displayName]!;
      isAbstract = accessor.isAbstract;
    }
    return !field.isStatic && !field.isConst && !isAbstract;
  };

  final allSuperFields =
      allSuperclasses.map((e) => e.fields).expand((e) => e).where(fieldFilter).toList();
  return [...clazz.fields, ...allSuperFields];
}

List<HashMap<String, SourceAssignment>> _targetToSource(List<ParameterElement> sources,
    ClassElement target, MethodElement method, Map<String, dynamic> config) {
  //<sourceClassElement,sourceParameterElement>
  //final sourceMap = {for (var e in sources) e.type.element as ClassElement: e};

  final caseSensitiveFields = config['caseSensitiveFields'];
  final fieldMapper = caseSensitiveFields ? (a) => a : (a) => a.toUpperCase();
  final equalsHashCode = caseSensitiveFields ? (a) => a.hashCode : (a) => a.toUpperCase().hashCode;
  final mappingConfig = MapperConfig.readMappingConfig(method);
  // final customMappingConfig = MapperConfig.readCustomMappingConfig(method);

  /// With HashMap you can specify how to compare keys
  /// It is very useful when you want to have caseInsensitive keys
  /// Contains data from @Mapping annotations
  var targetToSource = HashMap<String, SourceAssignment>(
      equals: (a, b) => fieldMapper(a) == fieldMapper(b), hashCode: (a) => equalsHashCode(a));

  /// Contains data from @CustomMapping annotations
  var customTargetToSource = HashMap<String, SourceAssignment>(
      equals: (a, b) => fieldMapper(a) == fieldMapper(b), hashCode: (a) => equalsHashCode(a));

  final mappingStringConfig = _extractStringMappingConfig(mappingConfig);
  for (final source in sources) {
    final sourceKey = source.type.element as ClassElement;
    final sourceValue = source;
    //<password,[password]>
    Map<String, List<String>> matchedSourceClazzInSourceMapping =
        _findMatchingSourceClazzInMappingMap(mappingStringConfig, sourceValue.displayName);
    if (!sourceKey.isAbstract) {
      for (var f in _findFields(sourceKey)) {
        //已经加过该元素
        if (targetToSource.containsKey(f.name) && !caseSensitiveFields) {
          final duplicatedKey = targetToSource.keys
              .toList()
              .firstWhere((k) => k.toUpperCase() == f.name.toUpperCase());
          throw InvalidGenerationSourceError(
              'Mapper got case insensitive fields and contains fields: ${f.name} and $duplicatedKey. If you use a case-sensitive mapper, make sure the fields are unique in a case insensitive way.',
              todo: "Use case sensitive mapper or change field's names");
        }
        //存在 mapping  target,source,parameter3部分匹配的元素
        //变量f也不是基础数据类型
        if (matchedSourceClazzInSourceMapping.isNotEmpty && _shouldSearchMoreFields(f)) {
          for (var matchedTarget in matchedSourceClazzInSourceMapping.keys) {
            //拿到值列表[user,token]
            final sourceValueList = matchedSourceClazzInSourceMapping[matchedTarget]!;
            //找到其所有函数
            final refChain = RefChain.byPropNames(sourceValue, sourceValueList.sublist(1));
            targetToSource[matchedTarget] = SourceAssignment.fromRefChain(refChain);
          }
        }
        //没有对应关系，或者f是基本数据类型
        else {
          targetToSource[f.name] = SourceAssignment.fromRefChain(RefChain([sourceValue, f]));
        }
      }
    } else {
      var fieldName = sourceValue.name;
      var returnTypeClassElement = method.returnType.element as ClassElement;
      var fieldElement = returnTypeClassElement.getField(fieldName);
      targetToSource[fieldName] = SourceAssignment.fromField(fieldElement, fieldName);
    }
  }

  /// If there are Mapping Annotations on the method, the source attribute of the source mapping class,
  /// will be replaced with the source attribute of the given mapping config.
  mappingConfig.forEach((targetField, mappingConfig) {
    final sourceField = mappingConfig.source;
    if (sourceField != null) {
      if (sourceField.toFunctionValue() != null) {
        targetToSource[targetField] =
            SourceAssignment.fromFunction(sourceField.toFunctionValue()!, [...sources]);
      } else if (sourceField.toStringValue() != null) {
        final sourceFieldString = sourceField.toStringValue()!;
        // sourceField exists in any sourceParam
        if (targetToSource.containsKey(sourceFieldString)) {
          if (!targetToSource[sourceFieldString]!.isStraight) {
            // replace mapping target with mapping
            targetToSource.putIfAbsent(targetField, () => targetToSource[sourceFieldString]!);
            targetToSource.remove(sourceFieldString);
          }
        }
      }
    }

    if (mappingConfig.ignore) {
      targetToSource.remove(targetField);
    }
  });
  return [targetToSource, customTargetToSource];
}

/// Extracts all Mapping Config Entries in [mappingConfig] which contains source mappings of type string
Map<String, MappingConfig> _extractStringMappingConfig(Map<String, MappingConfig> mappingConfig) {
  final mappingStringConfig = <String, MappingConfig>{};
  mappingConfig.forEach((key, value) {
    if (value.source != null && value.source!.toStringValue() != null) {
      mappingStringConfig.putIfAbsent(key, () => value);
    }
  });
  return mappingStringConfig;
}

Map<String, List<String>> _findMatchingSourceClazzInMappingMap(
    Map<String, MappingConfig> mappingStringConfig, String matchingSourceClazzName) {
  Map<String, List<String>> ret = {};
  mappingStringConfig.forEach((key, value) {
    // clazz.attribute1.attribute1_1
    final sourceValueList = value.source!.toStringValue()!.split(".");
    final sourceClass = sourceValueList[0];
    if (sourceClass == matchingSourceClazzName) {
      ret.putIfAbsent(key, () => sourceValueList);
    }
  });
  return ret;
}

/// A search for a potential underlying should only be continued, if the field is not a primitive type (string, int, double etc)
bool _shouldSearchMoreFields(FieldElement field) {
  return !field.type.isDartCoreString &&
      !field.type.isDartCoreBool &&
      !field.type.isDartCoreDouble &&
      !field.type.isDartCoreFunction &&
      !field.type.isDartCoreInt &&
      !field.type.isDartCoreIterable &&
      !field.type.isDartCoreList &&
      !field.type.isDartCoreMap &&
      !field.type.isDartCoreNull &&
      !field.type.isDartCoreNum &&
      !field.type.isDartCoreSet;
}