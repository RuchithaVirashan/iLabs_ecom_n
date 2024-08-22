import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/product_item_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<ProductItem> cartList = [];

  CartBloc() : super(CartInitial()) {
    on<AddToCart>((event, emit) => addToCart(emit, event.product));
  }

  void addToCart(
    Emitter<CartState> emit,
    ProductItem product,
  ) {
    emit(CartLoading());
    try {
      cartList.add(product);
      emit(CartLoaded(cartList: cartList));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}
