import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeCarouselSliderShimmer extends StatelessWidget {
  const HomeCarouselSliderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.sp),
      child: Shimmer.fromColors(
        baseColor: AppColors.lightGrey,
        highlightColor: Colors.white,
        child: CarouselSlider.builder(
          itemCount: 4,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
              Container(
            height: 120.h,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          options: CarouselOptions(
            autoPlay: true,
            height: 120.h,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 1,
            autoPlayCurve: Curves.fastOutSlowIn,
            aspectRatio: 2.0,
          ),
        ),
      ),
    );
  }
}
