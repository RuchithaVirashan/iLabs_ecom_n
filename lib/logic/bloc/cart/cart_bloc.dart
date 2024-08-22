import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/models/product_item_model.dart';
import '../../../presentation/components/status/error.dart';
import '../../../presentation/components/status/sucess.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<ProductItem> cartList = [];

  CartBloc() : super(CartInitial()) {
    on<AddToCart>(
        (event, emit) => addToCart(emit, event.product, event.context));

    on<RemoveFromCart>(
        (event, emit) => removeFromCart(emit, event.index, event.context));

    on<ClearCart>((event, emit) => clearCart(emit, event.context));
  }

  void addToCart(
    Emitter<CartState> emit,
    ProductItem product,
    BuildContext context,
  ) {
    emit(CartLoading());
    try {
      bool itemExists = cartList.any((item) => item.id == product.id);

      if (itemExists) {
        emit(CartLoaded(cartList: cartList));
        showErrorDialog(context, 'Item already exists in cart');
      } else {
        cartList.add(product);
        emit(CartLoaded(cartList: cartList));
        showSuccessDialog(context, 'Successfully added to cart', '/cart');
      }
    } catch (e) {
      emit(CartError(message: e.toString()));
      showErrorDialog(context, e.toString());
    }
  }

  void removeFromCart(
    Emitter<CartState> emit,
    int index,
    BuildContext context,
  ) {
    emit(CartLoading());
    try {
      cartList.removeAt(index);
      emit(CartLoaded(cartList: cartList));
    } catch (e) {
      emit(CartError(message: e.toString()));
      showErrorDialog(context, e.toString());
    }
  }

  void clearCart(Emitter<CartState> emit, BuildContext context) {
    emit(CartLoading());
    try {
      cartList.clear();
      emit(CartLoaded(cartList: cartList));
    } catch (e) {
      emit(CartError(message: e.toString()));
      showErrorDialog(context, e.toString());
    }
  }
}
