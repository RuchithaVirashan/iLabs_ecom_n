import 'package:flutter/material.dart';
import 'package:ilabsecomnew/presentation/screens/checkout_screen.dart';
import 'package:ilabsecomnew/presentation/screens/main_screen.dart';

import '../../data/models/product_item_model.dart';
import '../screens/item_details_screen.dart';

class AppRoute {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => const MainScreen(
                  selectedIndex: 0,
                ));
      case '/cart':
        return MaterialPageRoute(
            builder: (context) => const MainScreen(
                  selectedIndex: 1,
                ));
      case '/item_details':
        final ProductItem product = settings.arguments as ProductItem;
        return MaterialPageRoute(
          builder: (context) => ItemDetailsScreen(product: product),
        );

      case '/checkout':
        return MaterialPageRoute(builder: (context) => const CheckoutScreen());

      default:
        return MaterialPageRoute(
            builder: (context) => const MainScreen(
                  selectedIndex: 0,
                ));
    }
  }
}
