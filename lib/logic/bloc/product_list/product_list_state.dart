part of 'product_list_bloc.dart';

@immutable
sealed class ProductListState {}

final class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<ProductItem> productList;
  ProductListLoaded({required this.productList});
}

class ProductListError extends ProductListState {
  final String message;

  ProductListError({required this.message});
}
