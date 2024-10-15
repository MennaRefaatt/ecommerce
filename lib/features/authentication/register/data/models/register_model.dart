import 'package:freezed_annotation/freezed_annotation.dart';
part 'register_model.g.dart';

@JsonSerializable()
class RegisterResponse {
  bool? status;
  String? message;
  RegisterData? data;

  RegisterResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}

@JsonSerializable()
class RegisterData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? token;

  RegisterData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.token,
  });
  factory RegisterData.fromJson(Map<String, dynamic> json) =>
      _$RegisterDataFromJson(json);
}
