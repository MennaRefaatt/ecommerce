// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsModel _$ProductDetailsModelFromJson(Map<String, dynamic> json) =>
    ProductDetailsModel(
      status: json['status'] as bool?,
      data: json['data'] == null
          ? null
          : ProductDetailsData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductDetailsModelToJson(
        ProductDetailsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

ProductDetailsData _$ProductDetailsDataFromJson(Map<String, dynamic> json) =>
    ProductDetailsData(
      name: json['name'] as String?,
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toInt(),
      oldPrice: (json['oldPrice'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toInt(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      inFavorites: json['inFavorites'] as bool?,
      inCart: json['inCart'] as bool?,
    )
      ..id = (json['id'] as num?)?.toInt()
      ..description = json['description'] as String?;

Map<String, dynamic> _$ProductDetailsDataToJson(ProductDetailsData instance) =>
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
