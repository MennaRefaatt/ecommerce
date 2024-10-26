
import 'package:ecommerce/core/components/app_network_image.dart';
import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/core/services/navigation/app_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/app_bar.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../category_details/category_details_args.dart';
import '../manager/categories_cubit.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final cubit = CategoriesCubit(sl());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getCategoriesData(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              DefaultAppBar(text: S().categories, cartIcon: false, backArrow: true,),
              BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  } else if (state is CategoriesSuccess) {
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: state.categoriesModel.data!.data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Modular.to.pushNamed(AppEndpoints.categoryDetailsScreen,
                                arguments: CategoryDetailsArgs(
                                    id: state
                                        .categoriesModel.data!.data[index].id));
                              safePrint(state
                                  .categoriesModel.data!.data[index].id);
                            },
                            borderRadius: BorderRadius.circular(20.sp),
                            highlightColor: AppColors.primaryLight,
                            splashColor: Colors.transparent,
                            child: Container(
                              margin: EdgeInsets.all(15.sp),
                              child: Column(
                                children: [
                                  AppNetworkImage(
                                    imageUrl: state
                                        .categoriesModel.data!.data[index].image,
                                    width: double.infinity,
                                    height: 120.h,
                                    borderRadius: BorderRadius.circular(20.sp),
                                  ),
                                  verticalSpacing(10.h),
                                  Text(
                                    state.categoriesModel.data!.data[index].name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return const SizedBox(
                      child: Text("error"),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
