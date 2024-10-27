// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'favourite_model.dart';
//
// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************
//
// FavouriteModel _$FavouriteModelFromJson(Map<String, dynamic> json) =>
//     FavouriteModel(
//       status: json['status'] as bool?,
//       data: json['data'] == null
//           ? null
//           : FavouriteData.fromJson(json['data'] as Map<String, dynamic>),
//       message: json['message'] as String?,
//     );
//
// Map<String, dynamic> _$FavouriteModelToJson(FavouriteModel instance) =>
//     <String, dynamic>{
//       'message': instance.message,
//       'status': instance.status,
//       'data': instance.data,
//     };
//
// FavouriteData _$FavouriteDataFromJson(Map<String, dynamic> json) =>
//     FavouriteData(
//       data: (json['data'] as List<dynamic>?)
//           ?.map((e) => FavouriteDataList.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );
//
// Map<String, dynamic> _$FavouriteDataToJson(FavouriteData instance) =>
//     <String, dynamic>{
//       'data': instance.data,
//     };
//
// FavouriteDataList _$FavouriteDataListFromJson(Map<String, dynamic> json) =>
//     FavouriteDataList(
//       id: (json['id'] as num).toInt(),
//       product:
//           FavouriteProduct.fromJson(json['product'] as Map<String, dynamic>),
//     );
//
// Map<String, dynamic> _$FavouriteDataListToJson(FavouriteDataList instance) =>
//     <String, dynamic>{
//       'id': instance.id,
//       'product': instance.product,
//     };
//
// FavouriteProduct _$FavouriteProductFromJson(Map<String, dynamic> json) =>
//     FavouriteProduct(
//       id: (json['id'] as num).toInt(),
//       name: json['name'] as String,
//       image: json['image'] as String,
//       price: (json['price'] as num).toInt(),
//       oldPrice: (json['oldPrice'] as num).toInt(),
//       discount: (json['discount'] as num).toInt(),
//     );
//
// Map<String, dynamic> _$FavouriteProductToJson(FavouriteProduct instance) =>
//     <String, dynamic>{
//       'id': instance.id,
//       'name': instance.name,
//       'price': instance.price,
//       'oldPrice': instance.oldPrice,
//       'discount': instance.discount,
//       'image': instance.image,
//     };
