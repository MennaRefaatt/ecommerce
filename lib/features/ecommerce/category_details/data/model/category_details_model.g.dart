// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDetailsModel _$CategoryDetailsModelFromJson(
        Map<String, dynamic> json) =>
    CategoryDetailsModel(
      status: json['status'] as bool,
      data: json['data'] == null
          ? null
          : CategoryDetailsData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryDetailsModelToJson(
        CategoryDetailsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

CategoryDetailsData _$CategoryDetailsDataFromJson(Map<String, dynamic> json) =>
    CategoryDetailsData(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              CategoryDetailsListData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryDetailsDataToJson(
        CategoryDetailsData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

CategoryDetailsListData _$CategoryDetailsListDataFromJson(
        Map<String, dynamic> json) =>
    CategoryDetailsListData(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toInt(),
      oldPrice: (json['oldPrice'] as num).toInt(),
      discount: (json['discount'] as num).toInt(),
      image: json['image'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      inFavorites: json['inFavorites'] as bool,
      inCart: json['inCart'] as bool,
    );

Map<String, dynamic> _$CategoryDetailsListDataToJson(
        CategoryDetailsListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'oldPrice': instance.oldPrice,
      'discount': instance.discount,
      'image': instance.image,
      'images': instance.images,
      'inFavorites': instance.inFavorites,
      'inCart': instance.inCart,
    };
