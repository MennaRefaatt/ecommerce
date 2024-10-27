import 'package:ecommerce/core/services/navigation/app_endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/utils/app_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../cart/presentation/manager/cart_cubit.dart';
import '../../product_details_args.dart';

class AddToCartButtons extends StatelessWidget {
  AddToCartButtons(
      {super.key,
      required this.args,
      required this.cartCubit,
      required this.inCart});
  final ProductDetailsArgs args;
  bool inCart;
  final CartCubit cartCubit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(bottom: 15.sp),
          padding: EdgeInsets.all(15.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocListener<CartCubit, CartState>(
                listener: (context, state) {
                  if (state is CartError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        backgroundColor: AppColors.red,
                      )
                    );
                  }
                  if (state is CartSuccess) {
                    state.cartModel.message == "Added Successfully"
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.cartModel.message),
                              backgroundColor: AppColors.green,
                            ),
                          )
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.cartModel.message),
                              backgroundColor: AppColors.red,
                            ),
                          );
                  }
                },
                child: SizedBox(
                  width: inCart?200.w:50.w,
                  child: FloatingActionButton(
                    onPressed: () {
                      cartCubit.addProductToCart(
                        productId: args.id,
                      );
                      inCart = !inCart;
                    },
                    backgroundColor:inCart?  AppColors.red:Colors.white,
                    child: inCart
                        ? Padding(
                          padding:  EdgeInsets.all(8.0.sp),
                          child: const Text("Remove from cart",style: TextStyle(overflow: TextOverflow.ellipsis),),
                        )
                        : const Icon(
                            CupertinoIcons.cart_fill,
                            color: AppColors.primary,
                          ),
                  ),
                ),
              ),
              horizontalSpacing(15.w),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greyBorder.withOpacity(0.2),
                        blurRadius: 3.r,
                        offset: const Offset(2, 6),
                      ),
                    ]),
                child: AppButton(
                  width: 150,
                  onPressed: () {
                    if (inCart == true) {
                      Modular.to.pushNamed(AppEndpoints.cartScreen);
                    } else {
                      cartCubit
                          .addProductToCart(
                        productId: args.id,
                      )
                          .then((value) {
                        inCart = !inCart;
                        Modular.to.pushNamed(AppEndpoints.cartScreen);
                      });
                    }
                  },
                  text: S().buyNow,
                  textStyle: TextStyle(fontSize: 16.sp, color: Colors.white),
                  backgroundColor: AppColors.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
