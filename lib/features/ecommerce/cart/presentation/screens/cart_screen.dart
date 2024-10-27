
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/app_bar.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../favorite/presentation/manager/favourite_cubit.dart';
import '../manager/cart_cubit.dart';
import '../widgets/cart_widget.dart';
import '../widgets/order_info.dart';


class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final cubit = CartCubit(sl());
  final favouriteCubit = FavouriteCubit(sl());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getCartData(),
      child: Scaffold(
        body: Column(
          children: [
            DefaultAppBar(text: S().cart, cartIcon: false, backArrow: true),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(15.sp),
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
                      if(state.cartModel.data!.items.isEmpty){
                        return const Center(child: Text("no products in cart"),);
                      }else{
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                state.cartModel.data!.items.length.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              horizontalSpacing(2.w),
                              Text(S().products,
                                  style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          verticalSpacing(10.h),
                          CartWidget(
                            cartCubit: cubit,
                            cartModel: state.cartModel,
                          ),
                        ],
                      );}
                    }
                    return Container();
                  },
                ),
              ),
            ),
             OrderInfo(cartCubit: cubit,),
          ],
        ),
      ),
    );
  }
}
