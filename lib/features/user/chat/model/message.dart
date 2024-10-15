import 'package:freezed_annotation/freezed_annotation.dart';
part 'message.g.dart';

@JsonSerializable()
class MessageModel {
  final String id;
  final String message;
  final String createdAt;
  final String userId;

  MessageModel({
    required this.userId,
    required this.id,
    required this.message,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}

// import 'package:freezed_annotation/freezed_annotation.dart';
// part 'message.g.dart';
//
// @JsonSerializable()
// class MessageModel {
//   final String id;
//   final String message;
//
//   // Change to DateTime if you want to work with DateTime in Dart
//   @JsonKey(fromJson: _fromJson, toJson: _toJson)
//   final DateTime createdAt;
//
//   final String userId;
//
//   MessageModel({
//     required this.userId,
//     required this.id,
//     required this.message,
//     required this.createdAt,
//   });
//
//   factory MessageModel.fromJson(Map<String, dynamic> json) =>
//       _$MessageModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$MessageModelToJson(this);
//
//   // Helper methods for date serialization
//   static DateTime _fromJson(String date) => DateTime.parse(date);
//   static String _toJson(DateTime date) => date.toIso8601String();
// }
