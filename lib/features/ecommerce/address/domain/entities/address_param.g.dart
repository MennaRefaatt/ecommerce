// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressParam _$AddressParamFromJson(Map<String, dynamic> json) => AddressParam(
      name: json['name'] as String,
      city: json['city'] as String,
      region: json['region'] as String,
      details: json['details'] as String,
      notes: json['notes'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$AddressParamToJson(AddressParam instance) =>
    <String, dynamic>{
      'name': instance.name,
      'city': instance.city,
      'region': instance.region,
      'details': instance.details,
      'notes': instance.notes,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
