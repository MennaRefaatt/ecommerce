import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../orders/presentation/widget/animated_linear_progress_indicator.dart';
import '../../data/model/order_details_model.dart';

class OrderTrackingDetails extends StatefulWidget {
  const OrderTrackingDetails({super.key, required this.orderDetailsModel});
  final OrderDetailsModel orderDetailsModel;

  @override
  State<OrderTrackingDetails> createState() => _OrderTrackingDetailsState();
}

class _OrderTrackingDetailsState extends State<OrderTrackingDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Id",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                Text("#${widget.orderDetailsModel.data!.id.toString()}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: AppColors.primary)),
              ],
            ),
            widget.orderDetailsModel.data!.status == "Delivered" ||
                    widget.orderDetailsModel.data!.status == "New"
                ? Container(
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                      color: AppColors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(widget.orderDetailsModel.data!.status,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: AppColors.green)),
                  )
                : Container(
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                      color: AppColors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(widget.orderDetailsModel.data!.status,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: AppColors.red)),
                  ),
          ],
        ),
        verticalSpacing(10.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.sp),
          decoration: BoxDecoration(
            color: AppColors.greyBorder.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.orderDetailsModel.data!.date,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              AnimatedLinearProgressIndicator(
                  status: widget.orderDetailsModel.data!.status),
            ],
          ),
        )
      ],
    );
  }
}
