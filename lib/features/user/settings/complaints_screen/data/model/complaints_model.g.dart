// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaints_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintsModel _$ComplaintsModelFromJson(Map<String, dynamic> json) =>
    ComplaintsModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ComplaintsDataList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComplaintsModelToJson(ComplaintsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

ComplaintsDataList _$ComplaintsDataListFromJson(Map<String, dynamic> json) =>
    ComplaintsDataList(
      name: json['name'] as String?,
      email: json['email'] as String?,
      message: json['message'] as String?,
      phone: json['phone'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ComplaintsDataListToJson(ComplaintsDataList instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'message': instance.message,
      'phone': instance.phone,
      'id': instance.id,
    };
