import 'package:skye_utils/util/serialize/serializable.dart';
import 'package:skye_utils/util/serialize/serialize_util.dart';

///it's the form of info in the websocket communication
class WebSocketPackage extends Serializable {
  // id of the message , it's the primary key
  String? id;
  // if this message is the response of the message, the responseId will be the id of the corresponding message
  String? responseId;
  // the content of the websocket package
  dynamic content;
  // the date when the message is sent
  int? time;
  // the loop to the package
  String? loop;
  //the subject to the package
  String? subject;
  // the type of the webSocket message, because dart can't convert the enum type to string,so we must use string here
  String? webSocketPackageType;
  // the content in the message
  Map<String, dynamic>? additionalInfos;

  WebSocketPackage();

  WebSocketPackage.create({
    this.id,
    this.responseId,
    this.content,
    this.time,
    this.loop,
    this.subject,
    this.webSocketPackageType,
    this.additionalInfos,
  });

  @override
  fromJson(Map<String, dynamic> json) => WebSocketPackage.create(
        id: SerializeUtil.asT<String>(json["id"]),
        responseId: SerializeUtil.asT<String>(json["responseId"]),
        content: SerializeUtil.asT<dynamic>(json["content"]),
        time: SerializeUtil.asT<int>(json["time"]),
        loop: SerializeUtil.asT<String>(json["loop"]),
        subject: SerializeUtil.asT<String>(json["subject"]),
        webSocketPackageType: SerializeUtil.asT<String>(json["webSocketPackageType"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        "responseId": responseId,
        "content": content,
        "time": time,
        "loop": loop,
        "subject": subject,
        "webSocketPackageType": webSocketPackageType,
      };

  @override
  mapPair(Map<String, dynamic> json) => super.simpleMapPair(json, [
        'id',
        "responseId",
        "content",
        "time",
        "loop",
        "subject",
        "webSocketPackageType",
      ]);
}

///the WebSocketPackageType
class WebSocketPackageType {
  // request package
  static const REQUEST = "REQUEST";
  // response package
  static const RESPONSE = "RESPONSE";
}
