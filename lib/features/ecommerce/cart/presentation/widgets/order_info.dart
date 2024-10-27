
import 'package:ecommerce/core/services/navigation/app_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/utils/app_button.dart';
import '../../../../../generated/l10n.dart';
import '../manager/cart_cubit.dart';

class OrderInfo extends StatefulWidget {
  const OrderInfo({
    super.key,
    required this.cartCubit,
  });
  final CartCubit cartCubit;

  @override
  State<OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartLoading) {
          const CircularProgressIndicator(
            color: AppColors.primary,
          );
        }
        if (state is CartError) {
          const Text("Error");
        }
        if (state is CartSuccess) {
          setState(() {
            state.cartModel.data!.subTotal = state.cartModel.data!.subTotal;
          });
        }
      },
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          } else if (state is CartError) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else if (state is CartSuccess) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.greyBorder.withOpacity(0.2),
                      spreadRadius: 10,
                      blurRadius: 10,
                      offset: const Offset(7, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S().orderInfo,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                  ),
                  verticalSpacing(10.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${S().subTotal}: ",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.greyBorder),
                        ),
                      ),
                      Text(
                        "\$${state.cartModel.data!.subTotal.toString()}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  verticalSpacing(5.h),
                  Text(
                    "-------------------------------",
                    style: TextStyle(
                        color: AppColors.greyBorder.withOpacity(0.2),
                        fontSize: 40.sp),
                  ),
                  verticalSpacing(5.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${S().total}: ",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.black),
                        ),
                      ),
                      Text(
                        "\$${state.cartModel.data!.total.toString()}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  verticalSpacing(10.h),
                  Visibility(
                    visible: state.cartModel.data!.items.isNotEmpty,
                    child: Center(
                      child: AppButton(
                        width: 150,
                        onPressed: () {
                          widget.cartCubit.updateProductQuantity(
                              cartId: state.cartModel.data!.items[0].id,
                              quantity: state.cartModel.data!.items[0].quantity);
                          Modular.to.pushNamed(AppEndpoints.addressScreen);
                        },
                        backgroundColor: AppColors.primary,
                        text: S().checkout,
                        textStyle:TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white
                        ) ,
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
