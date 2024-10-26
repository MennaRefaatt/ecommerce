import 'package:json_annotation/json_annotation.dart';

part 'category_details_model.g.dart';

@JsonSerializable()
class CategoryDetailsModel {
  bool status;
  CategoryDetailsData? data;

  CategoryDetailsModel({
    required this.status,
    required this.data,
  });

  factory CategoryDetailsModel.fromJson(Map<String, dynamic> json) => _$CategoryDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDetailsModelToJson(this);
}

@JsonSerializable()
class CategoryDetailsData {
  List<CategoryDetailsListData> data;

  CategoryDetailsData({required this.data});

  factory CategoryDetailsData.fromJson(Map<String, dynamic> json) => _$CategoryDetailsDataFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDetailsDataToJson(this);
}

@JsonSerializable()
class CategoryDetailsListData {
  int id;
  String name;
  String description;
  int price;
  int oldPrice;
  int discount;
  String image;
  List<String> images;
  bool inFavorites;
  bool inCart;

  CategoryDetailsListData({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.images,
    required this.inFavorites,
    required this.inCart,
  });

  factory CategoryDetailsListData.fromJson(Map<String, dynamic> json) => _$CategoryDetailsListDataFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDetailsListDataToJson(this);
}
