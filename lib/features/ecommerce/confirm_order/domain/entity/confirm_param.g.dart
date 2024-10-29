// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmParam _$ConfirmParamFromJson(Map<String, dynamic> json) => ConfirmParam(
      addressId: (json['addressId'] as num).toInt(),
      paymentMethod: (json['paymentMethod'] as num).toInt(),
    );

Map<String, dynamic> _$ConfirmParamToJson(ConfirmParam instance) =>
    <String, dynamic>{
      'addressId': instance.addressId,
      'paymentMethod': instance.paymentMethod,
    };
