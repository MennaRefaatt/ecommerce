import 'package:json_annotation/json_annotation.dart';

part 'categories_model.g.dart';

@JsonSerializable()
class CategoriesModel {
  bool status;
  CategoriesData? data;

  CategoriesModel({required this.status, required this.data});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => _$CategoriesModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesModelToJson(this);
}

@JsonSerializable()
class CategoriesData {
  List<CategoriesDataList> data;

  CategoriesData({required this.data});

  factory CategoriesData.fromJson(Map<String, dynamic> json) => _$CategoriesDataFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesDataToJson(this);
}

@JsonSerializable()
class CategoriesDataList {
  int id;
  String name;
  String image;

  CategoriesDataList({required this.id, required this.name, required this.image});

  factory CategoriesDataList.fromJson(Map<String, dynamic> json) => _$CategoriesDataListFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesDataListToJson(this);
}
