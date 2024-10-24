import 'package:ecommerce/core/components/product_item_widget.dart';
import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/services/navigation/app_endpoints.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../favorite/presentation/manager/favourite_cubit.dart';
import '../../../../suggested_products/suggested_products_args.dart';
import '../../../domain/home_entity/home_entity.dart';

class HomeProductsListView extends StatefulWidget {
  const HomeProductsListView({
    super.key,
    required this.products,
    required this.favoriteCubit,
  });
  final List<ProductEntity> products;
  final FavouriteCubit favoriteCubit;
  @override
  State<HomeProductsListView> createState() => _HomeProductsListViewState();
}

class _HomeProductsListViewState extends State<HomeProductsListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.sp),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S().suggestedForYou,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              InkWell(
                onTap: () {
                  Modular.to.pushNamed(
                    AppEndpoints.suggestedProductsScreen,
                    arguments:
                        SuggestedProductsArgs(products: widget.products));
                  safePrint(widget.products.length.toString());
                  safePrint(SuggestedProductsArgs(products: widget.products).toString());
                },
                borderRadius: BorderRadius.circular(20.sp),
                child: Text(
                  S().seeAll,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 250.h,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    widget.products.length > 5 ? 5 : widget.products.length,
                itemBuilder: (context, index) {
                  return ProductItemWidget(
                    price: widget.products[index].price.toString(),
                    name: widget.products[index].name,
                    image: widget.products[index].image,
                    id: widget.products[index].id,
                    inFavorites: widget.products[index].isFav,
                    oldPrice: widget.products[index].oldPrice.toString(),
                    discount: widget.products[index].discount.toString(),
                    favoriteCubit: widget.favoriteCubit,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
