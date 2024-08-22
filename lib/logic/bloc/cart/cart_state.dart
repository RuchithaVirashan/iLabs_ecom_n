part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<ProductItem> cartList;
  CartLoaded({required this.cartList});
}

class CartError extends CartState {
  final String message;
  CartError({required this.message});
}
