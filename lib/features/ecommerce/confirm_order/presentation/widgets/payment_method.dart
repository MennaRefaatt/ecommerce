import 'package:ecommerce/core/helpers/shared_pref_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/shared_pref.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../cart/presentation/manager/cart_cubit.dart';
import '../../../payment/payment_view.dart';
import '../../payment_enum.dart';

class PaymentMethod extends StatefulWidget {
  final String? initialPaymentMethod;
  final void Function(String) onChange;
  const PaymentMethod(
      {super.key, required this.initialPaymentMethod, required this.onChange});
  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  late String selectedPaymentMethod;
  @override
  void initState() {
    super.initState();
    selectedPaymentMethod =
        widget.initialPaymentMethod ?? PaymentEnum.cashOnDelivery.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      int totalCost = 0;
      if (state is CartSuccess) {
        totalCost = state.cartModel.data!.total;
      }
      return Container(
        margin: EdgeInsets.all(15.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S().paymentMethod,
                style: TextStyle(
                    color: SharedPref.getBoolean(key: MySharedKeys.isDarkMode)
                        ? Colors.white
                        : AppColors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold)),
            verticalSpacing(10.h),
            selectPaymentMethod(
              onChange: (String? value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              },
              selectedPaymentMethod: selectedPaymentMethod,
              title: S().cashOnDelivery,
              value: PaymentEnum.cashOnDelivery.toString(),
              icon: Icons.delivery_dining,
            ),
            selectPaymentMethod(
                onChange: (String? value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                    if (selectedPaymentMethod ==
                        PaymentEnum.onlinePayment.toString()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PaymentView(totalCost: totalCost),
                        ),
                      );
                    }
                  });
                },
                selectedPaymentMethod: selectedPaymentMethod,
                title: S().onlinePayment,
                value: PaymentEnum.onlinePayment.toString(),
                icon: CupertinoIcons.creditcard,
                subtitle: "XXXX XXXX XXXX 1111"),
          ],
        ),
      );
    });
  }
}

selectPaymentMethod(
    {required void Function(String?) onChange,
    required String selectedPaymentMethod,
    required IconData icon,
    required String title,
    String? subtitle,
    required String value}) {
  return InkWell(
    onTap: () => onChange(value),
    borderRadius: BorderRadius.circular(10.r),
    child: Container(
      margin: EdgeInsets.all(15.sp),
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withOpacity(0.1),
        border: Border.all(color: AppColors.greyBorder),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary), // Icon for visa
        title: Text(title,
            style: TextStyle(
                color: SharedPref.getBoolean(key: MySharedKeys.isDarkMode)
                    ? Colors.white
                    : AppColors.black,
                fontWeight: FontWeight.bold)),
        subtitle: subtitle == null
            ? null
            : Text(
                subtitle,
                style: TextStyle(
                  color: SharedPref.getBoolean(key: MySharedKeys.isDarkMode)
                      ? Colors.white
                      : AppColors.black,
                ),
              ),
        trailing: SizedBox(
          width: 50.w,
          height: 50.h,
          child: CupertinoRadio<String>(
            value: value,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.greyInput,
            groupValue: selectedPaymentMethod,
            onChanged: (String? value) {
              onChange(value!);
            },
          ),
        ),
      ),
    ),
  );
}
