import 'package:json_annotation/json_annotation.dart';

part 'favourite_model.g.dart';

@JsonSerializable()
class FavouriteModel {
  final String? message;
  final bool? status;
  final FavouriteData? data;

  FavouriteModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavouriteModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteModelToJson(this);
}

@JsonSerializable()
class FavouriteData {
  final List<FavouriteDataList>? data;

  FavouriteData({required this.data});

  factory FavouriteData.fromJson(Map<String, dynamic> json) =>
      _$FavouriteDataFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteDataToJson(this);
}

@JsonSerializable()
class FavouriteDataList {
  final int id;
  final FavouriteProduct product;

  FavouriteDataList({
    required this.id,
    required this.product,
  });

  factory FavouriteDataList.fromJson(Map<String, dynamic> json) =>
      _$FavouriteDataListFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteDataListToJson(this);
}

@JsonSerializable()
class FavouriteProduct {
  final int id;
  final String name;
  final String price;
  final String oldPrice;
  final int discount;
  final String image;

  FavouriteProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.discount,
  });

  factory FavouriteProduct.fromJson(Map<String, dynamic> json) =>
      _$FavouriteProductFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteProductToJson(this);
}
