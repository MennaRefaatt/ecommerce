// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) => SearchModel(
      status: json['status'] as bool?,
      data: json['data'] == null
          ? null
          : SearchData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

SearchData _$SearchDataFromJson(Map<String, dynamic> json) => SearchData(
      searchDataList: (json['data'] as List<dynamic>?)
          ?.map((e) => SearchDataList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchDataToJson(SearchData instance) =>
    <String, dynamic>{
      'data': instance.searchDataList,
    };

SearchDataList _$SearchDataListFromJson(Map<String, dynamic> json) =>
    SearchDataList(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toInt(),
      inFavourite: json['in_favorites'] as bool?,
      inCart: json['in_cart'] as bool?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$SearchDataListToJson(SearchDataList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'in_favorites': instance.inFavourite,
      'in_cart': instance.inCart,
      'description': instance.description,
    };
