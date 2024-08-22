import 'package:flutter/material.dart';
import 'package:ilabsecomnew/presentation/screens/main_screen.dart';

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
      case '/details':
        return MaterialPageRoute(
            builder: (context) => const MainScreen(
                  selectedIndex: 1,
                ));
      default:
        return MaterialPageRoute(
            builder: (context) => const MainScreen(
                  selectedIndex: 0,
                ));
    }
  }
}
