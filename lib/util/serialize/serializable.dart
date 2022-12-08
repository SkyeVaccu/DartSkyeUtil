
///the interface showed serialize power
///if a class implements it , it should can be serialize or deserialize withe the map
abstract class Serializable {
  ///deserialize the json to a assets_entity
  ///@param json : the json object which is composed by basic type , list or map
  ///@return : the converted object
  dynamic fromJson(Map<String, dynamic> json);

  ///serialize the assets_entity to a json
  ///@return : convert the obj to json obj
  Map<String, dynamic> toJson();

  ///judge the map is pair the assets_entity attribute
  ///@param json : the json object
  ///@return : whether the json is match the attributes array
  bool mapPair(Map<String, dynamic> json);

  /// it can help the serializable object to complete the attribute pair
  /// @param json : the converted json
  /// @param attributes : all attributes of the class
  /// @return : the judge whether
  bool simpleMapPair(Map<String, dynamic> json, List<String> attributes) {
    //map contain redundant attribute
    if (json.length > attributes.length) {
      return false;
    }
    //traverse the map
    for (var entry in json.entries) {
      if (attributes.indexOf(entry.key) == -1) {
        return false;
      }
    }
    return true;
  }
}
