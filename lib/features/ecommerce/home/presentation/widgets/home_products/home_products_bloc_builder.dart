import 'package:ecommerce/features/ecommerce/home/presentation/widgets/home_products/home_products_list_view.dart';
import 'package:ecommerce/features/ecommerce/home/presentation/widgets/home_products/home_products_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/home_cubit.dart';

class HomeProductsBlocBuilder extends StatelessWidget {
  const HomeProductsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is HomeLoading) {
            return const HomeProductsShimmer();
          }
          if (state is HomeSuccess) {
            return HomeProductsListView(products: state.homeEntity.data.products);
          }
          if (state is HomeFailure) {
            return Center(
              child: Text(state.error),
            );
          }
          return const HomeProductsShimmer();
        });
  }
}
