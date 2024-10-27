// import 'package:json_annotation/json_annotation.dart';
//
// part 'cart_model.g.dart';
//
// @JsonSerializable()
// class CartModel {
//   final bool status;
//   final String message;
//   final CartData data;
//
//   CartModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//
//   factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);
//   Map<String, dynamic> toJson() => _$CartModelToJson(this);
// }
//
// @JsonSerializable()
// class CartData {
//   @JsonKey(name: 'sub_total')
//     int subTotal  = 0;
//     int total = 0;
//     @JsonKey(name: 'cart_items')
//    List<CartItems> items = [];
//
//
//   CartData({
//      required this.subTotal,
//     required this.total,
//     required this.items,
//   });
//
//   factory CartData.fromJson(Map<String, dynamic> json) => _$CartDataFromJson(json);
//   Map<String, dynamic> toJson() => _$CartDataToJson(this);
// }
//
// @JsonSerializable()
// class CartItems {
//   final int id;
//   final int quantity;
//   final CartProducts product;
//
//   CartItems({
//     required this.id,
//     required this.quantity,
//     required this.product,
//   });
//
//   factory CartItems.fromJson(Map<String, dynamic> json) => _$CartItemsFromJson(json);
//   Map<String, dynamic> toJson() => _$CartItemsToJson(this);
// }
//
// @JsonSerializable()
// class CartProducts {
//   final String name;
//   final String image;
//   final int price;
//   final int discount;
//   final int oldPrice;
//   final int id;
//   final String description;
//   final bool inFavorites;
//   final bool inCart;
//
//   CartProducts({
//     required this.name,
//     required this.image,
//     required this.price,
//     required this.discount,
//     required this.oldPrice,
//     required this.id,
//     required this.description,
//     required this.inFavorites,
//     required this.inCart,
//   });
//
//   factory CartProducts.fromJson(Map<String, dynamic> json) => _$CartProductsFromJson(json);
//   Map<String, dynamic> toJson() => _$CartProductsToJson(this);
// }
class CartModel {
  bool? _status;
  String? _message;
  CartData? _data;

  CartModel(
      {required bool status,
        required String message,
        required CartData data}) {
    _status = status;
    _message = message;
    _data = data;
  }

  CartModel.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? CartData.fromJson(json['data']) : null;
  }

  bool get status => _status ?? false;
  String get message => _message ?? '';
  CartData? get data => _data;
}

class CartData {
  int? _subTotal;
  int? _total;
  int? _id;
  int? _quantity;
  List<CartItems>? _items;
  CartProducts? _products;

  CartData(
      {required int subTotal,
        required int total,
        required int id,
        required int quantity,
        required CartProducts products,
        required List<CartItems> items}) {
    _subTotal = subTotal;
    _total = total;
    _products = products;
    _id = id;
    _quantity = quantity;
    _items = items;
  }

  CartData.fromJson(Map<String, dynamic> json) {
    _subTotal = json['sub_total'];
    _total = json['total'];
    if (json['cart_items'] != null) {
      _items = <CartItems>[];
      json['cart_items'].forEach((v) {
        _items!.add(CartItems.fromJson(v));
      });
    }
    if (json['product'] != null) {
      _products = CartProducts.fromJson(json['product']);
    }
    _id = json['id'];
    _quantity = json['quantity'];
  }

  CartProducts? get products => _products;
  int get id => _id ?? 0;
  int get quantity => _quantity ?? 0;
  int get subTotal => _subTotal ?? 0;
  int get total => _total ?? 0;
  List<CartItems> get items => _items ?? [];

  set quantity(int value) {
    _quantity = value;
  }

  set subTotal(int value) {
    _subTotal = value;
  }

  set total(int value) {
    _total = value;
  }
}

class CartItems {
  int? _id;
  int? _quantity;
  CartProducts? _product;
  CartItems({required int id, required int quantity, required CartProducts product}) {
    _id = id;
    _quantity = quantity;
    _product = product;
  }

  CartItems.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _quantity = json['quantity'];
    _product = CartProducts.fromJson(json['product']);
  }

  int get id => _id ?? 0;
  int get quantity => _quantity ?? 0;
  CartProducts? get product => _product;

  set quantity(int value) {
    _quantity = value;
  }
}

class CartProducts {
  String? _name;
  String? _image;
  String? _price;
  String? _discount;
  String? _oldPrice;
  int? _id;
  String? _description;
  bool? _inFavorites;
  bool? _inCart;

  CartProducts(
      {required String name,
        required String image,
        required String price,
        required String discount,
        required String oldPrice,
        required int id,
        required String description,
        required bool inFavorites,
        required bool inCart}) {
    _name = name;
    _image = image;
    _price = price;
    _discount = discount;
    _oldPrice = oldPrice;
    _id = id;
    _description = description;
    _inFavorites = inFavorites;
    _inCart = inCart;
  }

  CartProducts.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _image = json['image'];
    _price = json['price'].toString();
    _discount = json['discount'].toString();
    _oldPrice = json['old_price'].toString();
    _id = json['id'];
    _description = json['description'];
    _inFavorites = json['in_favorites'];
    _inCart = json['in_cart'];
  }

  String get name => _name ?? '';
  String get image => _image ?? '';
  String get price => _price ?? '';
  String get discount => _discount ?? '';
  String get oldPrice => _oldPrice ?? '';
  bool get inFavorites => _inFavorites ?? false;
  bool get inCart => _inCart ?? false;
  int get id => _id ?? 0;
  String get description => _description ?? '';
}
