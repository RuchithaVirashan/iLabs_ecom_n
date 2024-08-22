part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddToCart extends CartEvent {
  final ProductItem product;
  final BuildContext context;
  AddToCart({required this.product, required this.context});
}

class RemoveFromCart extends CartEvent {
  final int index;
  final BuildContext context;
  RemoveFromCart({required this.index, required this.context});
}

class ClearCart extends CartEvent {
  final BuildContext context;
  ClearCart({required this.context});
}
