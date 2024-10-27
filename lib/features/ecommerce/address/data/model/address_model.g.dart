// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => AddressDataListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      addressData: json['addressData'] == null
          ? null
          : AddressData.fromJson(json['addressData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'addressData': instance.addressData,
    };

AddressData _$AddressDataFromJson(Map<String, dynamic> json) => AddressData(
      data: (json['data'] as List<dynamic>)
          .map((e) => AddressDataListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddressDataToJson(AddressData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

AddressDataListModel _$AddressDataListModelFromJson(
        Map<String, dynamic> json) =>
    AddressDataListModel(
      name: json['name'] as String,
      city: json['city'] as String,
      region: json['region'] as String,
      details: json['details'] as String,
      notes: json['notes'] as String,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$AddressDataListModelToJson(
        AddressDataListModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'city': instance.city,
      'region': instance.region,
      'details': instance.details,
      'notes': instance.notes,
      'id': instance.id,
    };
