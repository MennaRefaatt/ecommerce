import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_model.g.dart';

@JsonSerializable()
class HomeModel {
  bool? status;
  HomeData? data;

  HomeModel({
    required this.status,
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);
}

@JsonSerializable()
class HomeData {
  List<HomeBanners> banners;
  List<HomeProducts> products;

  HomeData(
      {required this. banners,
      required this. products});
  factory HomeData.fromJson(Map<String, dynamic> json) =>
      _$HomeDataFromJson(json);
}

@JsonSerializable()
class HomeBanners {
  int? id;
  String? image;

  HomeBanners({
    required this.id,
    required this.image,
  });

  factory HomeBanners.fromJson(Map<String, dynamic> json) =>
      _$HomeBannersFromJson(json);
}

@JsonSerializable()
class HomeProducts {
  int? id;
  int? price;
  String? image;
  String? name;
  @JsonKey(name: 'in_favorites')
  bool? isFav;
  @JsonKey(name: 'old_price')
  int? oldPrice;
  int? discount;

  HomeProducts({
    required this.id,
    required this.price,
    required this.image,
    required this.name,
    required this.isFav,
    required this.oldPrice,
    required this.discount,
  });

  factory HomeProducts.fromJson(Map<String, dynamic> json) =>
      _$HomeProductsFromJson(json);
}
