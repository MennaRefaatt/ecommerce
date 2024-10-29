import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce/features/ecommerce/favorite/presentation/manager/favourite_cubit.dart';

import '../../../../../../core/components/product_item_widget.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../home/presentation/manager/home_cubit.dart';

class ProductsYouMightLike extends StatefulWidget {
  const ProductsYouMightLike({super.key, required this.favoriteCubit});
  final FavouriteCubit favoriteCubit;

  @override
  State<ProductsYouMightLike> createState() => _ProductsYouMightLikeState();
}

class _ProductsYouMightLikeState extends State<ProductsYouMightLike> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S().productsYouMightLike,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              }
              if (state is HomeSuccess) {
                if (state.homeEntity.data.products.isEmpty) {
                  return const Center(
                    child: Text('No products found'),
                  );
                }
                return SizedBox(
                  height: 300.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 5,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ProductItemWidget(
                          price: state.homeEntity.data.products[index].price
                              .toString(),
                          name: state.homeEntity.data.products[index].name,
                          image: state.homeEntity.data.products[index].image,
                          id: state.homeEntity.data.products[index].id,
                          inFavorites:
                              state.homeEntity.data.products[index].isFav,
                          oldPrice: state
                              .homeEntity.data.products[index].oldPrice
                              .toString(),
                          discount: state
                              .homeEntity.data.products[index].discount
                              .toString(),
                          favoriteCubit: widget.favoriteCubit,
                        );
                      }),
                );
              }
              return const Center(
                child: Text('No products found'),
              );
            },
          ),
        ],
      ),
    );
  }
}
