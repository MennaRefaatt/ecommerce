// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_success_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginSuccessResponse _$LoginSuccessResponseFromJson(
        Map<String, dynamic> json) =>
    LoginSuccessResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : LoginData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginSuccessResponseToJson(
        LoginSuccessResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
      userId: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'id': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'token': instance.token,
    };
