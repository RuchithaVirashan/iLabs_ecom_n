import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/product_item_model.dart';
import '../../../logic/bloc/cart/cart_bloc.dart';
import '../common/button.dart';
import '../common/default_text.dart';
import '../status/error.dart';
import '../status/sucess.dart';

class ItemCard extends StatelessWidget {
  final ProductItem product;

  const ItemCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color.fromRGBO(237, 237, 237, 1),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/item_details', arguments: product);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 4.h,
            horizontal: 8.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 100.h,
                ),
              ),
              SizedBox(height: 8.h),
              DefaultText(
                colorR: const Color.fromRGBO(25, 30, 29, 1),
                content: product.name,
                fontSizeR: 16.sp,
                fontWeightR: FontWeight.w600,
                textAlignR: TextAlign.start,
              ),
              SizedBox(height: 8.h),
              DefaultText(
                colorR: const Color.fromRGBO(25, 30, 29, 1),
                content: '\$${product.price.toStringAsFixed(2)}',
                fontSizeR: 14.sp,
                fontWeightR: FontWeight.w500,
                textAlignR: TextAlign.start,
              ),
              const Spacer(),
              ButtonWidget(
                onPressed: () async {
                  BlocProvider.of<CartBloc>(context)
                      .add(AddToCart(product: product));
                },
                minHeight: 30.h,
                buttonName: 'Add to Cart',
                tcolor: Colors.white,
                bcolor: const Color(0xFF154478),
                borderColor: Colors.white,
                radius: 15.r,
                fcolor: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
