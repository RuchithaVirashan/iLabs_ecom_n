part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddToCart extends CartEvent {
  final ProductItem product;
  AddToCart({required this.product});
}
