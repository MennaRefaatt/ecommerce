
import 'package:ecommerce/core/helpers/shared_pref.dart';
import 'package:ecommerce/core/services/navigation/app_endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/safe_print.dart';
import '../../../../../../core/helpers/shared_pref_keys.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../../order_details/order_details_args.dart';
import '../manager/orders_cubit.dart';
import 'animated_linear_progress_indicator.dart';

class OrdersList extends StatefulWidget {
  final bool isCurrentSelected;
  const OrdersList({super.key, required this.isCurrentSelected});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }
        if (state is OrdersError) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is OrdersSuccess) {
          final orders =
          widget.isCurrentSelected ? state.currentOrders : state.oldOrders;
          if (orders.isEmpty) {
            return Center(
              child: Text(S().noOrdersFound),
            );
          }
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return InkWell(
                borderRadius: BorderRadius.circular(20.sp),
                onTap: () {
                 Modular.to.pushNamed(AppEndpoints.orderDetailsScreen,
                      arguments: OrderDetailsArgs(id: orders[index].id));
                  safePrint(orders[index].id);
                },
                child: Container(
                  margin: EdgeInsets.all(15.sp),
                  padding: EdgeInsets.all(15.sp),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.sp),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greyBorder.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "#${orders[index].id}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            S().details,
                            style: const TextStyle(color: AppColors.primary),
                          ),
                        ],
                      ),
                      verticalSpacing(10.h),
                      Row(
                        children: [
                          const Icon(CupertinoIcons.location,
                              color: AppColors.primary),
                          horizontalSpacing(5.w),
                          Expanded(
                            child: Text(
                                SharedPref.getString(key: MySharedKeys.city)!),
                          ),
                          Text(
                            orders[index].date,
                            style: const TextStyle(color: AppColors.greyBorder),
                          ),
                        ],
                      ),
                      verticalSpacing(10.h),
                      Row(
                        children: [
                          Expanded(
                            child: AnimatedLinearProgressIndicator(status: orders[index].status),
                          ),
                          horizontalSpacing(10.w),
                          Text(
                            orders[index]
                                .status,
                            style: const TextStyle(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
