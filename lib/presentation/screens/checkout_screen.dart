import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilabsecomnew/data/models/product_item_model.dart';
import '../../data/models/order_model.dart';
import '../../logic/bloc/cart/cart_bloc.dart';
import '../../logic/cubit/user_data/user_data_cubit.dart';
import '../../services/validate.dart';
import '../components/common/back_app_bar.dart';
import '../components/common/button.dart';
import '../components/common/default_text.dart';
import '../components/common/text_feild.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final ValidateService validateService = ValidateService();

  List<ProductItem> cartItems = [];

  double getTotalPrice() {
    return cartItems.fold(0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      appBar: const BackAppBar(
        statename: 'Checkout',
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                      content: 'Shipping Information',
                      fontSizeR: 22.sp,
                      fontWeightR: FontWeight.bold,
                      colorR: Colors.black,
                      textAlignR: TextAlign.start,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: nameController,
                      hintText: 'Name',
                      validate: (value) => validateService.isEmptyField(value!),
                      keyBoardType: TextInputType.name,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: addressController,
                      hintText: 'Address',
                      validate: (value) => validateService.isEmptyField(value!),
                      keyBoardType: TextInputType.streetAddress,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: phoneNumberController,
                      hintText: 'Phone Number',
                      validate: (value) =>
                          validateService.validatePhoneNumber(value!),
                      keyBoardType: TextInputType.phone,
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                DefaultText(
                  content: 'Order Summary',
                  fontSizeR: 22.sp,
                  fontWeightR: FontWeight.bold,
                  colorR: Colors.black,
                  textAlignR: TextAlign.start,
                ),
                SizedBox(height: 16.h),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CartLoaded) {
                      cartItems = state.cartList;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DefaultText(
                                    content: cartItems[index].name,
                                    fontSizeR: 18.sp,
                                    fontWeightR: FontWeight.w500,
                                    colorR: Colors.black,
                                    textAlignR: TextAlign.start,
                                  ),
                                ),
                                DefaultText(
                                  content:
                                      '\$${cartItems[index].price.toStringAsFixed(2)}',
                                  fontSizeR: 18.sp,
                                  fontWeightR: FontWeight.w500,
                                  colorR: Colors.black,
                                  textAlignR: TextAlign.start,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 120.h,
        child: BottomAppBar(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultText(
                      content: 'Total:',
                      fontSizeR: 24.sp,
                      fontWeightR: FontWeight.bold,
                      colorR: Colors.black,
                      textAlignR: TextAlign.start,
                    ),
                    BlocSelector<CartBloc, CartState, CartState>(
                      selector: (state) {
                        return state;
                      },
                      builder: (context, state) {
                        return DefaultText(
                          content: '\$${getTotalPrice().toStringAsFixed(2)}',
                          fontSizeR: 24.sp,
                          fontWeightR: FontWeight.bold,
                          colorR: Colors.black,
                          textAlignR: TextAlign.start,
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: ButtonWidget(
                    onPressed: () {
                      final isValidForm = formKey.currentState!.validate();
                      if (isValidForm) {
                        OrderModel orderData = OrderModel(
                          customerName: nameController.text,
                          customerAddress: addressController.text,
                          customerPhoneNumber: phoneNumberController.text,
                          orderedItems: cartItems,
                          totalPrice: getTotalPrice(),
                          orderDate: DateTime.now(),
                        );

                        BlocProvider.of<UserDataCubit>(context)
                            .placeOrder(orderData, context);
                      }
                    },
                    minHeight: 55.h,
                    buttonName: 'Place Order',
                    tcolor: Colors.white,
                    bcolor: const Color(0xFF154478),
                    borderColor: Colors.white,
                    radius: 15.r,
                    fcolor: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
