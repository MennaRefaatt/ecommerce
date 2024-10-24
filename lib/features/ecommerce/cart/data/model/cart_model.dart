import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  final bool? status;
  final String? message;
  final CartData? data;

  CartModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}

@JsonSerializable()
class CartData {
  late final int? subTotal;
  late final int? total;
  final int? id;
  final int? quantity;
  final List<CartItems>? items;
  final CartProducts? products;

  CartData({
    required this.subTotal,
    required this.total,
    required this.id,
    required this.quantity,
    required this.products,
    required this.items,
  });

  factory CartData.fromJson(Map<String, dynamic> json) => _$CartDataFromJson(json);
  Map<String, dynamic> toJson() => _$CartDataToJson(this);
}

@JsonSerializable()
class CartItems {
  final int? id;
  final int? quantity;
  final CartProducts? product;

  CartItems({
    required this.id,
    required this.quantity,
    required this.product,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) => _$CartItemsFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemsToJson(this);
}

@JsonSerializable()
class CartProducts {
  final String? name;
  final String? image;
  final int? price;
  final int? discount;
  final int? oldPrice;
  final int? id;
  final String? description;
  final bool? inFavorites;
  final bool? inCart;

  CartProducts({
    required this.name,
    required this.image,
    required this.price,
    required this.discount,
    required this.oldPrice,
    required this.id,
    required this.description,
    required this.inFavorites,
    required this.inCart,
  });

  factory CartProducts.fromJson(Map<String, dynamic> json) => _$CartProductsFromJson(json);
  Map<String, dynamic> toJson() => _$CartProductsToJson(this);
}
