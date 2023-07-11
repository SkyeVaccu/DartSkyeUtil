import '../../../util/service/serialize/serializable.dart';
import '../../../util/service/serialize/serialize_util.dart';

class Emoji extends Serializable {
  //emoji name
  String? name;

  //emoji keyword
  List<String>? keywords;

  //emoji char
  String? char;

  //parent category
  String? category;

  Emoji.create({
    this.name,
    this.keywords,
    this.char,
    this.category,
  });

  @override
  fromJson(Map<String, dynamic> json) => Emoji.create(
      name: SerializeUtil.asT<String>(json["name"]),
      keywords: SerializeUtil.asT<List>(json['keywords'])?.cast<String>(),
      char: SerializeUtil.asT<String>(json["char"]),
      category: SerializeUtil.asT<String>(json["category"]));

  @override
  toJson() => {
        "name": name,
        "keywords": keywords,
        "char": char,
        "category": category,
      };

  @override
  mapPair(Map<String, dynamic> json) => super.simpleMapPair(json, [
        "name",
        "keywords",
        "char",
        "category",
      ]);
}
