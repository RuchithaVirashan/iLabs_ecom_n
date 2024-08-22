import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../logic/bloc/cart/cart_bloc.dart';
import '../components/common/default_text.dart';
import 'cart_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  final int selectedIndex;
  const MainScreen({super.key, required this.selectedIndex});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: [
          const HomeScreen(),
          const CartScreen(),
        ][selectedIndex],
        bottomNavigationBar: BlocSelector<CartBloc, CartState, CartState>(
          selector: (state) {
            return state;
          },
          builder: (context, state) {
            int cartItemCount = 0;
            if (state is CartLoaded) {
              cartItemCount = state.cartList.length;
            }
            return NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                  selectedIcon: Icon(Icons.home),
                ),
                NavigationDestination(
                  icon: Stack(
                    children: [
                      const Icon(Icons.shopping_cart_outlined),
                      if (cartItemCount > 0)
                        Positioned(
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 10.w,
                              minHeight: 10.h,
                            ),
                            child: DefaultText(
                              content: '$cartItemCount',
                              fontSizeR: 8.sp,
                              colorR: Colors.white,
                              textAlignR: TextAlign.center,
                              fontWeightR: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  label: 'Cart',
                  selectedIcon: Stack(
                    children: [
                      const Icon(Icons.shopping_cart),
                      if (cartItemCount > 0)
                        Positioned(
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 10.w,
                              minHeight: 10.h,
                            ),
                            child: DefaultText(
                              content: '$cartItemCount',
                              fontSizeR: 8.sp,
                              colorR: Colors.white,
                              textAlignR: TextAlign.center,
                              fontWeightR: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
