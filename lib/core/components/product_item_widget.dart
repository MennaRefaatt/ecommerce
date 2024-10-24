import 'package:ecommerce/core/components/app_network_image.dart';
import 'package:ecommerce/core/services/navigation/app_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/ecommerce/favorite/presentation/manager/favourite_cubit.dart';
import '../helpers/spacing.dart';
import '../theming/app_colors.dart';

class ProductItemWidget extends StatefulWidget {
  ProductItemWidget({
    super.key,
    required this.price,
    required this.name,
    required this.image,
    required this.id,
    required this.inFavorites,
    required this.oldPrice,
    required this.discount,
    required this.favoriteCubit,
    this.isFavScreen = false,
  });
  final String price;
  final String name;
  final String image;
  final int id;
  late bool inFavorites;
  final String oldPrice;
  final String discount;
  bool isFavScreen;
  final FavouriteCubit favoriteCubit;

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<FavouriteCubit, FavouriteState>(
      listener: (context, state) {
        if (state is FavouriteLoading) {
          const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }
      },
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: () => Modular.to.pushNamed(
          AppEndpoints.productDetailsScreen,
          // arguments: ProductDetailsArgs(id: widget.id)
        ),
        child: Container(
          width: 170.w,
          margin: EdgeInsets.all(10.sp),
          padding: EdgeInsets.all(15.sp),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              Flexible(
                child: AppNetworkImage(
                  imageUrl: widget.image,
                  width: 100.w,
                  height: 100.h,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              verticalSpacing(10.h),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: AppColors.primary,
                  ),
                  Text(
                    "4.9",
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
                  ),
                  widget.discount != "" && widget.discount != "0"
                      ? Container(
                    margin: EdgeInsets.all(8.sp),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.sp, vertical: 3.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: AppColors.primary.withOpacity(0.4),
                          ),
                          child: Text(
                            "${widget.discount}%",
                            style: const TextStyle(color: AppColors.greyBorder),
                          ),
                        )
                      : Container()
                ],
              ),
              verticalSpacing(10.h),
              Text(
                widget.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.black,
                    fontSize: 18.sp),
              ),
              Row(
                children: [
                  Text(
                    "\$${widget.price}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                        fontSize: 18.sp),
                  ),
                  horizontalSpacing(5.w),
                  Text(
                    "\$${widget.oldPrice}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.grey,
                      fontSize: 12.sp,
                      decoration: TextDecoration.lineThrough,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
