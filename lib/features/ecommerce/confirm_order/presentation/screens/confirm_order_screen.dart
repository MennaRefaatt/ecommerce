
import 'package:ecommerce/core/helpers/shared_pref.dart';
import 'package:ecommerce/core/services/navigation/app_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/app_bar.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/helpers/shared_pref_keys.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/utils/app_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../address/presentation/manager/address_cubit.dart';
import '../../../cart/presentation/manager/cart_cubit.dart';
import '../../confirm_order_args.dart';
import '../../payment_enum.dart';
import '../manager/confirm_order_cubit.dart';
import '../widgets/default_address.dart';
import '../widgets/item_details.dart';
import '../widgets/payment_method.dart';
class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({
    super.key,
  });
  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  final cubit = ConfirmOrderCubit(sl());
  final addressCubit = AddressCubit(sl());
  final cartCubit = CartCubit(sl());
  late int selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    selectedPaymentMethod = 1; // Default to "Cash on Delivery"
  }

  void _updatePaymentMethod(String method) {
    setState(() {
      selectedPaymentMethod = method == PaymentEnum.cashOnDelivery.toString() ? 1 : 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => cubit,
        ),
        BlocProvider(
          create: (context) => addressCubit..getAddress(),
        ),
        BlocProvider(
          create: (context) => cartCubit..getCartData(),
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              DefaultAppBar(
                text: S().confirmOrder,
                cartIcon: false,
                backArrow: true,
              ),
              Divider(
                thickness: 1.sp,
                color: AppColors.greyBorder.withOpacity(0.1),
              ),
              const DefaultAddress(),
              Divider(
                thickness: 5.sp,
                color: AppColors.greyBorder.withOpacity(0.1),
              ),
              const ItemDetails(),
              Divider(
                thickness: 5.sp,
                color: AppColors.greyBorder.withOpacity(0.1),
              ),
              PaymentMethod(
                initialPaymentMethod: selectedPaymentMethod.toString(),
                onChange: _updatePaymentMethod,
              ),
              AppButton(
                onPressed: () {
                  // TODO: COMPLETE NAVIGATION
                 Modular.to.navigate(AppEndpoints.orderPlacedScreen,arguments:ConfirmOrderArgs(id: 1));///toDo add id
                  cubit.addConfirmOrderData(
                    addressId:
                        SharedPref.getInt(key: MySharedKeys.defaultAddressId)!,
                    paymentMethod: selectedPaymentMethod,
                  );
                },
                text: S().confirmOrder,
                backgroundColor: AppColors.primary,
                textStyle: TextStyle(
                  color: Colors.white ,
                  fontSize: 20.sp,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
