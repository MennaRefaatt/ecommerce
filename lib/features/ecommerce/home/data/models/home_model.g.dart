// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => HomeModel(
      status: json['status'] as bool?,
      data: json['data'] == null
          ? null
          : HomeData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

HomeData _$HomeDataFromJson(Map<String, dynamic> json) => HomeData(
      banners: (json['banners'] as List<dynamic>)
          .map((e) => HomeBanners.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List<dynamic>)
          .map((e) => HomeProducts.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeDataToJson(HomeData instance) => <String, dynamic>{
      'banners': instance.banners,
      'products': instance.products,
    };

HomeBanners _$HomeBannersFromJson(Map<String, dynamic> json) => HomeBanners(
      id: (json['id'] as num?)?.toInt(),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$HomeBannersToJson(HomeBanners instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
    };

HomeProducts _$HomeProductsFromJson(Map<String, dynamic> json) => HomeProducts(
      id: (json['id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      image: json['image'] as String?,
      name: json['name'] as String?,
      isFav: json['in_favorites'] as bool?,
      oldPrice: (json['old_price'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$HomeProductsToJson(HomeProducts instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'image': instance.image,
      'name': instance.name,
      'in_favorites': instance.isFav,
      'old_price': instance.oldPrice,
      'discount': instance.discount,
    };
