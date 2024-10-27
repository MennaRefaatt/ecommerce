
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/components/app_bar.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../order_details_args.dart';
import '../manager/order_details_cubit.dart';
import '../widgets/cancel_order_button.dart';
import '../widgets/order_address_details.dart';
import '../widgets/order_payment_method_details.dart';
import '../widgets/order_products_details.dart';
import '../widgets/order_tracking_details.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.orderDetailsArgs});
  final OrderDetailsArgs orderDetailsArgs;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final orderDetailsCubit = OrderDetailsCubit(sl());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => orderDetailsCubit
        ..getOrderDetails(id: widget.orderDetailsArgs.id.toString()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              DefaultAppBar(
                  text: S().orderDetails, cartIcon: false, backArrow: true),
              BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
                builder: (context, state) {
                  if (state is OrderDetailsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }
                  if (state is OrderDetailsError) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  if (state is OrderDetailsSuccess) {
                    if (state.orderDetailsModel.data!.products.isEmpty) {
                      return const Center(
                        child: Text('No products found'),
                      );
                    }
                    return Container(
                      margin: EdgeInsets.all(15.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OrderTrackingDetails(
                            orderDetailsModel: state.orderDetailsModel,
                          ),
                          verticalSpacing(10.h),
                          OrderAddressDetails(
                            orderDetailsModel: state.orderDetailsModel,
                          ),
                          verticalSpacing(10.h),
                          OrderProductsDetails(
                            products: state.orderDetailsModel.data!.products,
                          ),
                          verticalSpacing(10.h),
                          OrderPaymentMethodDetails(
                            orderDetailsModel: state.orderDetailsModel,
                          ),
                          verticalSpacing(10.h),
                          CancelOrderButton(
                            args: widget.orderDetailsArgs,
                            orderDetailsModel: state.orderDetailsModel,
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
