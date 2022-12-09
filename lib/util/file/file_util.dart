import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:skye_utils/util/file/directory_type.dart';
import 'package:skye_utils/util/isolate_util.dart';
import 'package:skye_utils/util/serialize/serialize_util.dart';

///it's used to operate the file
class FileUtil {
  ///create a operator
  ///@param fileName : the name of the file
  ///@param directoryType : the file storage path
  ///@return : the file operator
  static Future<Operator> operate(String fileName,
      {DirectoryType directoryType = DirectoryType.ApplicationDocumentsDirectory}) async {
    //get the file
    dynamic directory = await directoryType.info;
    //if directory is null then throw exception
    if (directory == null) {
      throw "can't find the directory";
    } else {
      late File file;
      if (directory is Directory) {
        //create or get the new File object
        file = File(directory.path + "/" + fileName);
      } else {
        //create or get the new File object
        file = File((directory as List<Directory>)[0].path + "/" + fileName);
      }
      return Operator(file);
    }
  }
}

/// it's the true operator which operate the file
class Operator {
  //the target file
  File file;

  /// the constructor file
  Operator(this.file);

  ///read the File content as String in the another thread
  ///@return : the content of the file as bytes
  Future<List<int>> readFileAsBytes() async {
    return await IsolateUtil.builder(_readFileAsByte).setParameter(file).run();
  }

  ///read the File content as String in the another thread
  ///@return : the content of the file as String
  Future<String> readFileAsString() async {
    return await IsolateUtil.builder(_readFileAsString).setParameter(file).run();
  }

  ///read the File content as object in the another thread
  ///@param targetObject : the target object of type
  ///@return : the converted object
  Future<dynamic> readFileAsObject({dynamic targetObject}) async {
    return await IsolateUtil.builder(_readFileAsObject)
        .setParameter(file)
        .setParameter(targetObject)
        .run();
  }

  ///write the byte into the file in the another thread
  ///@param content : the string content which will be written into the file
  ///@param needCover : whether the new content cover the old content
  void writeFileBytes(String content, {bool needCover = false}) {
    IsolateUtil.builder(_writeFileBytes)
        .setParameter(file)
        .setParameter(utf8.encode(content))
        .setParameter(needCover)
        .run();
  }

  ///write the String into the file in the another thread
  ///@param content : the string content which will be written into the file
  ///@param needCover : whether the new content cover the old content
  void writeFileString(String content, {bool needCover = false}) {
    IsolateUtil.builder(_writeFileString)
        .setParameter(file)
        .setParameter(content)
        .setParameter(needCover)
        .run();
  }

  ///write the object into the file in the another thread
  ///@param content : the content which will be written into the file
  ///@param needCover : whether the new content cover the old content
  void writeFileAsObject(dynamic content, {bool needCover = false}) {
    IsolateUtil.builder(_writeFileAsObject)
        .setParameter(file)
        .setParameter(SerializeUtil.asBasic(content))
        .setParameter(needCover)
        .run();
  }

  /// read the file content as byte, the true method which is executed
  /// @param parameter : the parameter list
  /// @return : the file content as String
  static FutureOr<dynamic> _readFileAsByte(List<dynamic> parameter) async {
    var file = parameter[0] as File;
    if (!(await file.exists())) {
      throw "can't find the file";
    } else {
      return await file.readAsBytes();
    }
  }

  /// read the file content as String, the true method which is executed
  /// @param parameter : the parameter list
  /// @return : the file content as String
  static FutureOr<dynamic> _readFileAsString(List<dynamic> parameter) async {
    var file = parameter[0] as File;
    if (!(await file.exists())) {
      throw "can't find the file";
    } else {
      return await file.readAsString();
    }
  }

  ///read the file content as object
  /// @param parameter : the parameter list
  /// @return : the file content as Object
  static FutureOr<dynamic> _readFileAsObject(List<dynamic> parameter) async {
    //read the file file as String
    String fileContentStr = await _readFileAsString(parameter);
    //decode the file content
    var obj = jsonDecode(fileContentStr);
    if (parameter[1] != null) {
      return SerializeUtil.asCustomized(obj, parameter[1]);
    }
    return obj;
  }

  ///write bytes into the file
  /// @param parameter : the parameter list
  /// @return : the file content as Object
  static void _writeFileBytes(List<dynamic> parameter) {
    (parameter[0] as File).writeAsBytes(parameter[1] as List<int>, flush: parameter[2] as bool);
  }

  ///write String into the file
  /// @param parameter : the parameter list
  /// @return : the file content as Object
  static void _writeFileString(List<dynamic> parameter) {
    (parameter[0] as File).writeAsString(parameter[1] as String, flush: parameter[2] as bool);
  }

  ///convert the object to the json and write into the file
  /// @param parameter : the parameter list
  /// @return : the file content as Object
  static void _writeFileAsObject(List<dynamic> parameter) {
    (parameter[0] as File).writeAsString(jsonEncode(parameter[1]), flush: parameter[2] as bool);
  }
}
