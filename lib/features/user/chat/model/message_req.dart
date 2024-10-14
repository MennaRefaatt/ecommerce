import 'package:freezed_annotation/freezed_annotation.dart';
part 'message_req.g.dart';

@JsonSerializable()
class MessageReq {
  String message;

  @JsonKey(name: 'userId')
  String id;
  MessageReq({
    required this.message,
    required this.id,
  });

  Map<String, dynamic> toJson() => _$MessageReqToJson(this);
}
