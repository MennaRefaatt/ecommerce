part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final CartModel cartModel;
  CartSuccess({required this.cartModel});
}

final class CartError extends CartState {
  final String error;
  CartError({required this.error});
}
final class RemoveSuccess extends CartState {
  final bool success;
  RemoveSuccess({required this.success});
}
final class RemoveError extends CartState {
  final String error;
  RemoveError({required this.error});
}
final class UpdateSuccess extends CartState {
  final CartModel cartModel;
  UpdateSuccess({required this.cartModel});
}

final class UpdateError extends CartState {
  final String error;
  UpdateError({required this.error});
}
final class AddSuccess extends CartState {
  final CartModel cartModel;
  AddSuccess({required this.cartModel});
}

final class AddError extends CartState {
  final String error;
  AddError({required this.error});
}
