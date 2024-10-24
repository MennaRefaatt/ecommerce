
import 'package:ecommerce/features/ecommerce/product_details/presentation/widgets/product_details_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../cart/presentation/manager/cart_cubit.dart';
import '../../../favorite/presentation/manager/favourite_cubit.dart';
import '../../data/model/product_details_model.dart';
import '../manager/product_details_cubit.dart';

class ProductDetailsWidget extends StatefulWidget {
  ProductDetailsWidget(
      {super.key,
      required this.productDetailsData,
      required this.productId,
      required this.isFavourite,
      required this.favoriteCubit,
      required this.cartCubit});
  final ProductDetailsData productDetailsData;
  final int productId;
  late bool isFavourite;
  final FavouriteCubit favoriteCubit;
  final CartCubit cartCubit;

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is ProductDetailsError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error.toString()),
              backgroundColor: Colors.red[900],
            ));
          }

          if (state is ProductDetailsLoading) {
            const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }
        },
        child: ProductDetailsDescription(
          productDetailsData: widget.productDetailsData,
          productId: widget.productId,
          isFavourite: widget.isFavourite,
          favoriteCubit: widget.favoriteCubit,
          cartCubit: widget.cartCubit,
        ));
  }
}
