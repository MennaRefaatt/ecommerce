import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/utils/app_button.dart';
import '../../../../../../generated/l10n.dart';
import '../../data/model/order_details_model.dart';
import '../../order_details_args.dart';
import '../manager/order_details_cubit.dart';

class CancelOrderButton extends StatelessWidget {
  const CancelOrderButton(
      {super.key, required this.args, required this.orderDetailsModel});
  final OrderDetailsArgs args;
  final OrderDetailsModel orderDetailsModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
      builder: (context, state) {
        if (state is CancelOrderSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.cancelOrderModel.message),
              backgroundColor: AppColors.green,
            ),
          );
          Navigator.pop(context);
        }
        if (state is CancelOrderError) {
          return Center(
            child: Text(state.error),
          );
        }
        return orderDetailsModel.data!.status == "New" ||
                orderDetailsModel.data!.status == "delivered" ||
                orderDetailsModel.data!.status == "جديد"
            ? Center(
                child: AppButton(
                  onPressed: () {
                    context
                        .read<OrderDetailsCubit>()
                        .cancelOrder(orderId: args.id);
                  },
                  backgroundColor: Colors.red[900]!,
                  text: S().cancelOrder,
                  textStyle: const TextStyle(color: Colors.white),
                ),
              )
            : Container();
      },
    );
  }
}
