import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class SkeletonLoaderItem extends StatelessWidget {
  const SkeletonLoaderItem({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return SkeletonLoader(
      builder: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.grey[200],
        ),
        height: 180.h,
      ),
    );
  }
}
