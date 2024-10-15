import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/components/app_network_image.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../domain/home_entity/home_entity.dart';

class HomeCarouselSlider extends StatelessWidget {
  const HomeCarouselSlider({super.key, required this.banners});
  final List<BannerEntity> banners;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 7,
            spreadRadius: 1,
            offset: const Offset(0, 10), // Shadow position
          ),
        ],
      ),
      child: CarouselSlider.builder(
        itemCount: banners.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            AppNetworkImage(
          imageUrl: banners[itemIndex].image,
          width: double.infinity,
          height: 120.h,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(20.r),
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
    );
  }
}
