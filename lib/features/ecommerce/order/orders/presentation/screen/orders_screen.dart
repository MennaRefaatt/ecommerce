
import 'package:ecommerce/core/components/app_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/components/app_bar.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../manager/orders_cubit.dart';
import '../widget/animatedButton.dart';
import '../widget/order_list.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final ordersCubit = OrdersCubit(sl());
  bool isCurrentSelected = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ordersCubit..getOrders(),
      child: Scaffold(
        bottomNavigationBar: const AppBottomNavBar(index: 1),
        body: Column(
          children: [
            DefaultAppBar(text: S().orders, cartIcon: false, backArrow: false),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 10.sp),
              decoration: BoxDecoration(
                color: AppColors.greyBorder.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedButton(
                    isSelected: isCurrentSelected,
                    text: "Current",
                    onTap: () {
                      setState(() {
                        isCurrentSelected = true;
                      });
                    },
                  ),
                  horizontalSpacing(10.w),
                  AnimatedButton(
                    isSelected: !isCurrentSelected,
                    text: S().old,
                    onTap: () {
                      setState(() {
                        isCurrentSelected = false;
                      });
                    },
                  ),
                ],
              ),
            ),
            verticalSpacing(10.h),
            Expanded(
              child: OrdersList(isCurrentSelected: isCurrentSelected),
            ),
          ],
        ),
      ),
    );
  }
}
