
import 'package:freezed_annotation/freezed_annotation.dart';
part 'message.g.dart';
@JsonSerializable()
class MessageModel {
  final String id;
  final String message;
  final DateTime createdAt;

  MessageModel({
    required this.id,
    required this.message,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}

