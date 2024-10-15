import 'package:ecommerce/features/ecommerce/home/presentation/manager/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_carousel_slider.dart';
import 'home_carousel_slider_shimmer.dart';
class SliderBlocBuilder extends StatelessWidget {
  const SliderBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is HomeLoading) {
            return const HomeCarouselSliderShimmer();
          }
          if (state is HomeSuccess) {
            return HomeCarouselSlider(banners: state.homeEntity.data.banners);
          }
          if (state is HomeFailure) {
            return Center(
              child: Text(state.error),
            );
          }
          return const HomeCarouselSliderShimmer();
    });
  }
}
