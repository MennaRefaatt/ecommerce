import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'address_param.g.dart';
@JsonSerializable()
class AddressParam {
  final String name;
  final String city;
  final String region;
  final String details;
  final String notes;
  final double latitude;
  final double longitude;
  AddressParam({
    required this.name,
    required this.city,
    required this.region,
    required this.details,
    required this.notes,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => _$AddressParamToJson(this);

  factory AddressParam.fromJson(Map<String, dynamic> json) => _$AddressParamFromJson(json);
}