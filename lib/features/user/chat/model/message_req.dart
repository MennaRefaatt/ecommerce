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

// import 'package:freezed_annotation/freezed_annotation.dart';
// part 'message_req.g.dart';
//
// @JsonSerializable()
// class MessageReq {
//   final String message;
//
//   // Change id to userId for consistency
//   @JsonKey(name: 'userId')
//   final String userId;
//
//   MessageReq({
//     required this.message,
//     required this.userId,
//   });
//
//   factory MessageReq.fromJson(Map<String, dynamic> json) =>
//       _$MessageReqFromJson(json);
//
//   Map<String, dynamic> toJson() => _$MessageReqToJson(this);
// }
