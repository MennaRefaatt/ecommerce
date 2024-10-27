
import 'package:ecommerce/core/components/app_network_image.dart';
import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/components/app_bar.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../cart/presentation/manager/cart_cubit.dart';
import '../../../favorite/presentation/manager/favourite_cubit.dart';
import '../../data/model/product_details_model.dart';
import '../../product_details_args.dart';
import '../manager/product_details_cubit.dart';
import '../widgets/add_to_cart_buttons.dart';
import '../widgets/product_details_description.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.args});
  final ProductDetailsArgs args;
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final cubit = ProductDetailsCubit(sl());
  final favoriteCubit = FavouriteCubit(sl());
  final cartCubit = CartCubit(sl());
  late final ProductDetailsData productDetailsData;

  @override
  Widget build(BuildContext context) {
    safePrint(widget.args.id);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              cubit..getProductDetails(productId: widget.args.id),
        ),
        BlocProvider(
          create: (context) => favoriteCubit,
        ),
        BlocProvider(create: (context) => cartCubit),
      ],
      child: Scaffold(
        body: Column(
          children: [
            DefaultAppBar(
              text: S().productDetails,
              cartIcon: false,
              backArrow: true,
            ),
            BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                builder: (context, state) {
              if (state is ProductDetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              }
              if (state is ProductDetailsError) {
                return Center(
                  child: Text(state.error),
                );
              }
              if (state is ProductDetailsSuccess) {
                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            ImageSlideshow(
                              indicatorColor: AppColors.primary,
                              indicatorBackgroundColor: AppColors.backGround,
                              initialPage: 0,
                              indicatorRadius: 5.sp,
                              onPageChanged: (value) {
                                debugPrint('Page changed: $value');
                              },
                              autoPlayInterval: 3000,
                              isLoop: false,
                              children: state.productDetailsModel.data!.images
                                  .map(
                                    (e) => AppNetworkImage(
                                        imageUrl: e,
                                        width: double.infinity,
                                        borderRadius: BorderRadius.circular(0.sp)),
                                  )
                                  .toList(),
                            ),
                            ProductDetailsDescription(
                              productDetailsData: state.productDetailsModel.data!,
                              productId: widget.args.id,
                              isFavourite: state.productDetailsModel.data!.inFavorites,
                              favoriteCubit: favoriteCubit,
                              cartCubit: cartCubit,
                            ),

                          ],
                        ),
                      ),
                      AddToCartButtons(args: widget.args, cartCubit: cartCubit, inCart: state.productDetailsModel.data!.inCart,),
                    ],
                  ),
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
