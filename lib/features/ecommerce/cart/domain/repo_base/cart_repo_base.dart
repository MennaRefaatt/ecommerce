import '../../data/model/cart_model.dart';
import '../entity/cart_param.dart';

abstract class CartRepoBase {
  Future<CartModel?> getCart();
  Future<bool> deleteCart(CartParam cartParam);
  Future<CartModel> setCart(CartParam cartParam);
  Future<CartModel> updateCart(CartParam cartParam);
}