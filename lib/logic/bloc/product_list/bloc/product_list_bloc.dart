import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/product_item_model.dart';
import '../../../../data/repositories/product_list_repo.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductListRepository productListRepo = ProductListRepository();

  ProductListBloc() : super(ProductListInitial()) {
    on<FetchProductList>(fetchProductList);
  }

  Future<void> fetchProductList(
    ProductListEvent event,
    Emitter<ProductListState> emit,
  ) async {
    emit(ProductListLoading());
    try {
      final productList = await productListRepo.getProductList();
      emit(ProductListLoaded(productList: productList));
    } catch (e) {
      emit(ProductListError(message: e.toString()));
    }
  }
}
