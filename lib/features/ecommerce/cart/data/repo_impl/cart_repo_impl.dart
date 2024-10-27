import 'package:ecommerce/core/helpers/safe_print.dart';

import '../../domain/entity/cart_param.dart';
import '../../domain/repo_base/cart_repo_base.dart';
import '../data_source/ds_cart_remote.dart';
import '../model/cart_model.dart';

class CartRepoImpl implements CartRepoBase {
final DSCartRemote dataSource;
CartRepoImpl(this.dataSource);

  @override
  Future<CartModel> getCart() async {
    final response = await dataSource.getCart();
    try {
      safePrint("repo ===> $response");
      if(response!.status==true){
        return response;
      }
      return response;
    } catch (e) {
      safePrint("Error $e");
      return Future.error(e);
    }
  }

  @override
  Future<bool> deleteCart(CartParam cartParam) async {
    final response = await dataSource.deleteCart(cartParam);
    try {
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<CartModel> setCart(CartParam cartParam) async {
    final response = await dataSource.setCart(cartParam);
    try {
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<CartModel> updateCart(CartParam cartParam) async {
    final response = await dataSource.updateCart(cartParam);
    try {
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}