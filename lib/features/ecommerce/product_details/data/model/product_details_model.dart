import 'package:json_annotation/json_annotation.dart';
part 'product_details_model.g.dart';

@JsonSerializable()
class ProductDetailsModel {
  bool? status;
  ProductDetailsData? data;

  ProductDetailsModel({
    required this.status,
    required this.data,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => _$ProductDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDetailsModelToJson(this);
}

@JsonSerializable()
class ProductDetailsData {
  int? id;
  String? name;
  String? description;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  ProductDetailsData({
    required this.name,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.images,
    required this.inFavorites,
    required this.inCart,
  });

  factory ProductDetailsData.fromJson(Map<String, dynamic> json) => _$ProductDetailsDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDetailsDataToJson(this);
}
