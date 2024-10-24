// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : CartData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

CartData _$CartDataFromJson(Map<String, dynamic> json) => CartData(
      subTotal: (json['subTotal'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      products: json['products'] == null
          ? null
          : CartProducts.fromJson(json['products'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => CartItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartDataToJson(CartData instance) => <String, dynamic>{
      'subTotal': instance.subTotal,
      'total': instance.total,
      'id': instance.id,
      'quantity': instance.quantity,
      'items': instance.items,
      'products': instance.products,
    };

CartItems _$CartItemsFromJson(Map<String, dynamic> json) => CartItems(
      id: (json['id'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      product: json['product'] == null
          ? null
          : CartProducts.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartItemsToJson(CartItems instance) => <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'product': instance.product,
    };

CartProducts _$CartProductsFromJson(Map<String, dynamic> json) => CartProducts(
      name: json['name'] as String?,
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toInt(),
      oldPrice: (json['oldPrice'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      description: json['description'] as String?,
      inFavorites: json['inFavorites'] as bool?,
      inCart: json['inCart'] as bool?,
    );

Map<String, dynamic> _$CartProductsToJson(CartProducts instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'discount': instance.discount,
      'oldPrice': instance.oldPrice,
      'id': instance.id,
      'description': instance.description,
      'inFavorites': instance.inFavorites,
      'inCart': instance.inCart,
    };
