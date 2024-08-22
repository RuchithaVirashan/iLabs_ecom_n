import 'package:dio/dio.dart';

import '../../utils/constants.dart';
import '../models/product_item_model.dart';

class ProductListRepository {
  Future<List<ProductItem>> getProductList() async {
    String productListAPIUrl = '${Constants.baseurl}product';

    final response = await Dio().get(
      productListAPIUrl,
    );
    if (response.statusCode == 200) {
      List<ProductItem> items = [];
      for (var item in response.data) {
        items.add(ProductItem.fromJson(item));
      }
      return items;
    } else {
      throw Exception('Failed to load product list');
    }
  }
}
