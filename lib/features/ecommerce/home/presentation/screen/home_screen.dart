
import 'package:ecommerce/core/components/app_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../search/presentation/manager/search_cubit.dart';
import '../manager/home_cubit.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_carousel_slider.dart';
import '../widgets/home_products_list_view.dart';
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
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          } else if (state is HomeSuccess) {
            return SingleChildScrollView(
              child: Container(
                color: Theme.of(context).colorScheme.onPrimary,
                child: Column(
                  children: [
                    verticalSpacing(20.h),
                     HomeAppbar(),
                    SearchBarr(searchCubit: searchCubit,),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Column(
                          children: [
                        verticalSpacing(20.h),
                         HomeCarouselSlider(
                          banners: state.homeEntity.data.banners,
                        ),
                        //const HomeCategories(),
                        HomeProductsListView(
                          products: state.homeEntity.data.products,
                         // favoriteCubit: favoriteCubit,
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
