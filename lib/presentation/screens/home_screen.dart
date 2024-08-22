import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../logic/bloc/product_list/product_list_bloc.dart';
import '../components/common/default_text.dart';
import '../components/common/header_text.dart';
import '../components/home/item_card.dart';
import '../components/home/skeloeton_loader_item.dart';
import '../components/status/error.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<ProductListBloc>(context).add(FetchProductList());
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 150.h,
                collapsedHeight: 100.h,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  title: HeaderText(
                    colorR: Colors.black,
                    content: 'Buy the best quality products at the best prices',
                    fontSizeR: 18.sp,
                    fontWeightR: FontWeight.bold,
                    textAlignR: TextAlign.center,
                    letterSpace: 6.sp,
                  ),
                  centerTitle: true,
                  titlePadding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 5.w,
                      ),
                      child: BlocBuilder<ProductListBloc, ProductListState>(
                        builder: (context, state) {
                          if (state is ProductListInitial) {
                            BlocProvider.of<ProductListBloc>(context)
                                .add(FetchProductList());
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is ProductListLoading) {
                            return SkeletonLoader(
                              period: const Duration(seconds: 5),
                              highlightColor: Colors.grey[300]!,
                              builder: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: 8,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.w,
                                  mainAxisSpacing: 10.h,
                                  childAspectRatio: 0.75,
                                ),
                                itemBuilder: (context, index) {
                                  return const SkeletonLoaderItem();
                                },
                              ),
                            );
                          } else if (state is ProductListError) {
                            showErrorDialog(context, state.message);
                            return Center(
                                child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: DefaultText(
                                content: state.message,
                                colorR: Colors.red,
                                fontSizeR: 14.sp,
                                textAlignR: TextAlign.center,
                                fontWeightR: FontWeight.bold,
                              ),
                            ));
                          } else if (state is ProductListLoaded) {
                            final productList = state.productList;
                            return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: productList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                                childAspectRatio: 0.75,
                              ),
                              itemBuilder: (context, index) {
                                return ItemCard(
                                  product: productList[index],
                                );
                              },
                            );
                          }

                          return Container();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
