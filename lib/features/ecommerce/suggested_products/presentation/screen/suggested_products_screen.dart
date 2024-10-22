import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/components/app_bar.dart';
import '../../../../../core/components/product_item_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../favorite/presentation/manager/favourite_cubit.dart';
import '../../suggested_products_args.dart';

class SuggestedProductsScreen extends StatefulWidget {
  const SuggestedProductsScreen({
    super.key,
    required this.args,
  });

  final SuggestedProductsArgs args;

  @override
  State<SuggestedProductsScreen> createState() =>
      _SuggestedProductsScreenState();
}

class _SuggestedProductsScreenState extends State<SuggestedProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final favouriteCubit = context.read<FavouriteCubit>();

    safePrint("Products received: ${widget.args.products.length}"); // Debug log
    return BlocProvider(
      create: (context) => favouriteCubit,
      child: Scaffold(
        body: Column(
          children: [
            DefaultAppBar(
              text: S().suggestedForYou,
              cartIcon: false,
              backArrow: true,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.sp,
                  crossAxisSpacing: 0.sp,
                  childAspectRatio: 0.62.sp,
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.args.products.length,
                itemBuilder: (context, index) {
                  return ProductItemWidget(
                    price: widget.args.products[index].price.toString(),
                    name: widget.args.products[index].name,
                    image: widget.args.products[index].image,
                    id: widget.args.products[index].id,
                    inFavorites: widget.args.products[index].isFav,
                    oldPrice: widget.args.products[index].oldPrice.toString(),
                    discount: widget.args.products[index].discount.toString(),
                    favoriteCubit: favouriteCubit,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
