import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/product_item_model.dart';
import '../../logic/bloc/cart/cart_bloc.dart';
import '../components/cart/cart_item_card.dart';
import '../components/cart/no_item_message.dart';
import '../components/cart/order_summary.dart';
import '../components/common/back_app_bar.dart';
import '../components/common/button.dart';
import '../components/common/header_text.dart';
import '../components/status/error.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BlocConsumer<CartBloc, CartState>(
      listenWhen: (previous, current) => current is CartError,
      listener: (context, state) {
        if (state is CartError) {
          showErrorDialog(context, state.message);
        }
      },
      buildWhen: (previous, current) =>
          current is CartLoading || current is CartLoaded,
      builder: (context, state) {
        if (state is CartInitial) {
          return const NoItemMsg();
        }
        if (state is CartLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CartLoaded) {
          List<ProductItem> cartItems = state.cartList;
          return cartItems.isEmpty
              ? const NoItemMsg()
              : Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: HeaderText(
                      colorR: Colors.black,
                      content: 'Cart',
                      fontSizeR: 18.sp,
                      fontWeightR: FontWeight.bold,
                      textAlignR: TextAlign.center,
                      letterSpace: 6.sp,
                    ),
                  ),
                  body: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              return CartItemCard(
                                index: index,
                                cartItems: cartItems,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 8.h),
                        OrderSummaryDet(cartItems: cartItems),
                      ],
                    ),
                  ),
                  bottomNavigationBar: Visibility(
                    visible: cartItems.isNotEmpty,
                    child: SizedBox(
                      height: 70.h,
                      child: BottomAppBar(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: ButtonWidget(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/checkout');
                            },
                            minHeight: 55.h,
                            buttonName: 'Checkout',
                            tcolor: Colors.white,
                            bcolor: const Color(0xFF154478),
                            borderColor: Colors.white,
                            radius: 15.r,
                            fcolor: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
        }
        return Container();
      },
    );
  }
}
