import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  bool status;
  String message;
  List<AddressDataListModel> data;
  AddressData? addressData;

  AddressModel({
    required this.status,
    required this.message,
    required this.data,
    this.addressData,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}

@JsonSerializable()
class AddressData {
  List<AddressDataListModel> data;

  AddressData({required this.data});

  factory AddressData.fromJson(Map<String, dynamic> json) => _$AddressDataFromJson(json);
  Map<String, dynamic> toJson() => _$AddressDataToJson(this);
}

@JsonSerializable()
class AddressDataListModel {
  String name;
  String city;
  String region;
  String details;
  String notes;
  int id;

  AddressDataListModel({
    required this.name,
    required this.city,
    required this.region,
    required this.details,
    required this.notes,
    required this.id,
  });

  factory AddressDataListModel.fromJson(Map<String, dynamic> json) => _$AddressDataListModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressDataListModelToJson(this);
}
