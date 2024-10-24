import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/ecommerce/cart/data/repo_impl/cart_repo_impl.dart';
import 'package:flutter/cupertino.dart';

import '../../data/model/cart_model.dart';
import '../../domain/entity/cart_param.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepoImpl) : super(CartInitial());
final CartRepoImpl cartRepoImpl;
  void getCartData() {
    emit(CartLoading());
 final result=  cartRepoImpl.getCart();
    result.then((value) {
      emit(CartSuccess(cartModel: value!));
    }).onError((error, stackTrace) {
      emit(CartError(error: error.toString()));
    });
  }

 Future addProductToCart({required int productId}) async{
    emit(CartLoading());

    final result=  cartRepoImpl.setCart(CartParam(productId: productId, cartId: 0, quantity: 1));
    result.then((value) {
      emit(AddSuccess(cartModel: value));
    }).onError((error, stackTrace) {
      emit(AddError(error: error.toString()));
    });

  }

  removeProductFromCart({required int cartId}) {
    emit(CartLoading());

    final result=  cartRepoImpl.deleteCart(CartParam(cartId: cartId, productId: 0, quantity: 1));
    result.then((value) {
      emit(RemoveSuccess(success: value));
    }).onError((error, stackTrace) {
      emit(RemoveError(error: error.toString()));
    });

  }

  updateProductQuantity({required int cartId, required int quantity}) {

    emit(CartLoading());
    final result=  cartRepoImpl.updateCart(CartParam(cartId: cartId, productId: 0, quantity: quantity));
    result.then((value) {
      emit(UpdateSuccess(cartModel: value));
    }).onError((error, stackTrace) {
      emit(UpdateError(error: error.toString()));
    });
  }

}
