import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/core/services/network/api_service.dart';
import 'package:ecommerce/features/ecommerce/cart/data/model/cart_model.dart';
import 'package:ecommerce/features/ecommerce/cart/domain/entity/cart_param.dart';

import '../../../../../core/services/network/api_constants.dart';

abstract class DSCartRemote {
  Future<CartModel?> getCart();
  Future<bool> deleteCart(CartParam cartParam);
  Future<CartModel> setCart(CartParam cartParam);
  Future<CartModel> updateCart(CartParam cartParam);
}

class DSCartRemoteImpl implements DSCartRemote {
  DSCartRemoteImpl();

  @override
  Future<bool> deleteCart(CartParam cartParam) async {
    final response = await ApiService.deleteData(
        endPoint: EndPoints.cartDelete + cartParam.cartId.toString());
    try {
      reCalculateTotals(response);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<CartModel> getCart() async {
    final response = await ApiService.getData(endPoint: EndPoints.cart);
    try {
      safePrint(response);
      CartModel cartModel = CartModel.fromJson(response);
      return cartModel;
    } catch (e) {
      safePrint("Error remote $e");
      return Future.error(e);
    }
  }

  @override
  Future<CartModel> setCart(CartParam cartParam) async {
    final response =
        await ApiService.postData(endPoint: EndPoints.cart, data: {
      'product_id': cartParam.productId,
    });
    try {
      CartModel cartModel = CartModel.fromJson(response);
      reCalculateTotals(cartModel);
      return cartModel;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<CartModel> updateCart(CartParam cartParam) async {
    final response = await ApiService.putData(
        endPoint: EndPoints.cartUpdate + cartParam.cartId.toString(),
        data: {'quantity': cartParam.quantity});
    try {
      CartModel cartModel = CartModel.fromJson(response);
      reCalculateTotals(cartModel);
      return cartModel;
    } catch (e) {
      return Future.error(e);
    }
  }

  void reCalculateTotals(CartModel cartModel) {
    int newSubTotal = 0;
    int newTotal = 0;

    for (var item in cartModel.data!.items!) {
      int itemTotal = item.quantity! * int.parse(item.product!.price!.toString());
      newSubTotal += itemTotal;
    }

    // Add any additional logic for total calculation if needed
    newTotal = newSubTotal; // Adjust if there are other fees or discounts

    // cartModel.data.subTotal = newSubTotal;
    // cartModel.data.total = newTotal;
  }
}
