import 'package:ecommerce/core/components/app_network_image.dart';
import 'package:ecommerce/core/helpers/shared_pref.dart';
import 'package:ecommerce/features/ecommerce/payment/service/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paymob_payment/paymob_payment.dart';

import '../../../core/helpers/shared_pref_keys.dart';
import '../../../core/theming/app_colors.dart';

class PaymentView extends StatefulWidget {
  final int totalCost;

  const PaymentView({super.key, required this.totalCost});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  PaymobResponse? response;

  void _makePayment() async {
    final paymentKey =
        await PaymobManager().getPaymentKey(widget.totalCost, "EGP");
    PaymobPayment.instance.pay(
      context: context,
      currency: "EGP",
      amountInCents: (widget.totalCost * 100).toString(),
      billingData: PaymobBillingData(
        email: SharedPref.getString(key: MySharedKeys.email),
        phoneNumber: SharedPref.getString(key: MySharedKeys.phone),
        firstName: SharedPref.getString(key: MySharedKeys.userName),
        city: SharedPref.getString(key: MySharedKeys.city),
        shippingMethod: "Pickup",
      ),
      onPayment: (response) {
        setState(() {
          this.response = response;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 190.h,
            width: double.infinity,
            padding: EdgeInsets.all(20.sp),
            decoration: BoxDecoration(
              color: SharedPref.getBoolean(key: MySharedKeys.isDarkMode)
                  ? Colors.black87
                  : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(10,1),
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                response != null
                    ? Container()
                    : IconButton(
                        icon: Icon(CupertinoIcons.back,
                            color: SharedPref.getBoolean(
                                    key: MySharedKeys.isDarkMode)
                                ? Colors.white
                                : AppColors.black,
                            size: 30.sp),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                const AppNetworkImage(
                  imageUrl: 'https://paymob.com/images/logoC.png',
                  width: double.infinity,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          response != null
              ? Column(
                  children: [
                    Icon(
                      response!.responseCode == "APPROVED"
                          ? CupertinoIcons.checkmark_seal_fill
                          : CupertinoIcons.xmark_seal_fill,
                      size: 60.sp,
                      color: response!.responseCode == "APPROVED"
                          ? Colors.green
                          : Colors.red,
                    ),
                    Text(
                      response!.responseCode == "APPROVED"
                          ? "Payment Successful"
                          : "Payment Failed",
                      style: TextStyle(
                        color: response!.responseCode == "APPROVED"
                            ? Colors.green
                            : Colors.red,
                        fontSize: 20.sp,
                      ),
                    ),
                    if (response!.success)
                      Text("Transaction ID: ${response!.transactionID}",
                          style: const TextStyle(color: Colors.black)),
                  ],
                )
              : ElevatedButton(
                  onPressed: _makePayment,
                  child: Text(
                    'Pay ${widget.totalCost} EGP',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
        ],
      ),
    );
  }
}
