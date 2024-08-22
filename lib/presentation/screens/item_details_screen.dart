import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/product_item_model.dart';
import '../../logic/bloc/cart/cart_bloc.dart';
import '../components/common/back_app_bar.dart';
import '../components/common/button.dart';
import '../components/common/default_text.dart';

class ItemDetailsScreen extends StatefulWidget {
  final ProductItem product;

  const ItemDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      appBar: const BackAppBar(
        statename: 'Product Details',
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                  widget.product.image,
                  height: 300.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16.h),
            DefaultText(
              content: widget.product.name,
              fontSizeR: 24.sp,
              fontWeightR: FontWeight.bold,
              textAlignR: TextAlign.left,
              colorR: Colors.black,
            ),
            SizedBox(height: 8.h),
            DefaultText(
              content: '\$${widget.product.price.toStringAsFixed(2)}',
              fontSizeR: 20.sp,
              fontWeightR: FontWeight.w500,
              textAlignR: TextAlign.left,
              colorR: Colors.black,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70.h,
        child: BottomAppBar(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ButtonWidget(
              onPressed: () async {
                BlocProvider.of<CartBloc>(context)
                    .add(AddToCart(product: widget.product));
              },
              minHeight: 55.h,
              buttonName: 'Add to Cart',
              tcolor: Colors.white,
              bcolor: const Color(0xFF154478),
              borderColor: Colors.white,
              radius: 15.r,
              fcolor: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
