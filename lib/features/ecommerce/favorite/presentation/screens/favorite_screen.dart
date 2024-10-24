import 'package:ecommerce/core/components/app_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/components/app_bar.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../manager/favourite_cubit.dart';
import '../widget/favourite_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    super.key,
  });
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const AppBottomNavBar(index: 2),
        body: SingleChildScrollView(
          child: Column(
            children: [
              DefaultAppBar(
                text: S().favorite,
                cartIcon: false,
                backArrow: false,
              ),
              BlocBuilder<FavouriteCubit, FavouriteState>(
                builder: (context, state) {
                  if (state is FavouriteLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  } else if (state is FavouriteError) {
                    return Center(
                      child: Text(state.error.toString()),
                    );
                  } else if (state is FavouriteSuccess) {
                    if (state.favouriteModel.data!.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          'No favourite products found',
                        ),
                      );
                    }
                    return FavouriteWidget(
                        favouriteCubit: context.read<FavouriteCubit>(),
                        data: state.favouriteModel.data!,
                        inFavorites: true);
                  }
                  return Text(state.toString());
                },
              ),
            ],
          ),
        ));
  }
}
