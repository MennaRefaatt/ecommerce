import 'package:ecommerce/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeProductsShimmer extends StatelessWidget {
  const HomeProductsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15.sp),
        child: Shimmer.fromColors(
          baseColor: AppColors.lightGrey,
          highlightColor: Colors.white,
          child: SizedBox(
            height: 250.h,
            child: ListView.builder(
              itemCount: 4,
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.all(10.sp),
                width: 170.w,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text("ddfsd"),
              ),
            ),
          ),
        ));
  }
}
