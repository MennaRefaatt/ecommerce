import 'package:ecommerce/core/components/app_bottom_nav_bar.dart';
import 'package:ecommerce/features/ecommerce/home/presentation/widgets/home_carousel_slider/slider_bloc_builder.dart';
import 'package:ecommerce/features/ecommerce/home/presentation/widgets/home_products/home_products_bloc_builder.dart';
import 'package:ecommerce/features/ecommerce/home/presentation/widgets/home_products/home_products_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../search/presentation/manager/search_cubit.dart';
import '../manager/home_cubit.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cubit = HomeCubit(sl());
  // final categoryCubit = CategoriesCubit();
  final favoriteCubit = ();
  final searchCubit = SearchCubit(sl());
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => cubit..getHomeData(),
        ),

        // BlocProvider(
        //   create: (context) => categoryCubit..getCategoriesData(),
        // ),
        // BlocProvider(create: (context) => favoriteCubit),
        BlocProvider(create: (context) => searchCubit),
      ],
      child: Scaffold(
        bottomNavigationBar: const AppBottomNavBar(index: 0),
        body: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).colorScheme.onPrimary,
            child: Column(
              children: [
                verticalSpacing(20.h),
                HomeAppbar(),
                SearchBarr(
                  searchCubit: searchCubit,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                  ),
                  child: Column(children: [
                    verticalSpacing(20.h),
                    const SliderBlocBuilder(),
                    //const HomeCategories(),
                    const HomeProductsBlocBuilder(),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
