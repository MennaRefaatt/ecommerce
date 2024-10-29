// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_pass_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePassParam _$ChangePassParamFromJson(Map<String, dynamic> json) =>
    ChangePassParam(
      currentPassword: json['currentPassword'] as String,
      newPassword: json['newPassword'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$ChangePassParamToJson(ChangePassParam instance) =>
    <String, dynamic>{
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
      'confirmPassword': instance.confirmPassword,
    };
