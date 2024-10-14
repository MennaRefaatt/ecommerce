import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_success_response.g.dart';

@JsonSerializable()
class LoginSuccessResponse {
  bool? status;
  String? message;
  LoginData? data;

  LoginSuccessResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginSuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginSuccessResponseFromJson(json);
}

@JsonSerializable()
class LoginData {
  @JsonKey(name: 'id')
  int? userId;
  String? name;
  String? email;
  String? phone;
  String? token;

  LoginData({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.token,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);
}
