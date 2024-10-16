// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaints_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintsParam _$ComplaintsParamFromJson(Map<String, dynamic> json) =>
    ComplaintsParam(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ComplaintsParamToJson(ComplaintsParam instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'message': instance.message,
    };
