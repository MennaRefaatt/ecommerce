import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/app_bar.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../category_details/category_details_args.dart';
import '../../../favorite/presentation/manager/favourite_cubit.dart';
import '../manager/category_details_cubit.dart';
import '../widgets/category_details_widget.dart';

class CategoryDetailsScreen extends StatefulWidget {
  const CategoryDetailsScreen({super.key, required this.args});

  final CategoryDetailsArgs args;

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  final cubit = CategoryDetailsCubit(sl());
  final favoriteCubit = FavouriteCubit(sl());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              cubit..getCategoryDetails(categoryId: widget.args.id),
        ),
        BlocProvider(
          create: (context) => favoriteCubit,
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            DefaultAppBar(text: S().categoryDetails, cartIcon: true, backArrow: true,),
            BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
                builder: (context, state) {
              if (state is CategoryDetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              }
              if (state is CategoryDetailsError) {
                return Center(
                  child: Text(state.error),
                );
              }
              if (state is CategoryDetailsSuccess) {
                return CategoryDetailsWidget(
                  categoryDetailsData: state.categoryDetailsModel.data!,
                  favouriteCubit: favoriteCubit,
                );
              }
              return const SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
