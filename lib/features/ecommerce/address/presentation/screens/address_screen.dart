
import 'package:ecommerce/core/helpers/shared_pref.dart';
import 'package:ecommerce/core/services/navigation/app_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/components/app_bar.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/helpers/safe_print.dart';
import '../../../../../core/helpers/shared_pref_keys.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/utils/app_button.dart';
import '../../../../../generated/l10n.dart';
import '../manager/address_cubit.dart';
import '../widgets/saved_addresses_list_view.dart';
import 'add_address_screen/address_args.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});
  final cubit = AddressCubit(sl());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getAddress(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              DefaultAppBar(
                text: S().address,
                cartIcon: false,
                backArrow: true,
              ),
              Container(
                margin: EdgeInsets.all(15.sp),
                child: Column(
                  children: [
                    Text(
                      S().savedAddresses,
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    BlocBuilder<AddressCubit, AddressState>(
                      builder: (context, state) {
                        if (state is AddressLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          );
                        } else if (state is AddressError) {
                          return Center(
                            child: Text(state.error),
                          );
                        } else if (state is AddressSuccess) {
                          if (state.addressModel.addressData == null) {
                            return const Center(
                              child: Text('No address found'),
                            );
                          }
                          return SavedAddressesListView(
                            cubit: cubit,
                            addressData: state.addressModel.addressData!,
                            args: AddressArgs(addressModel: state.addressModel),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    verticalSpacing(20.h),
                    AppButton(
                      onPressed: () =>
                          Modular.to.pushNamed(AppEndpoints.addAddressScreen),
                      backgroundColor: AppColors.primary,
                      text: S().addNewAddress,
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),),
                    verticalSpacing(20.h),
                    Center(
                      child: AppButton(
                          onPressed: () {
                            Modular.to.pushNamed(AppEndpoints.confirmOrderScreen,);
                            safePrint(SharedPref.getInt(key: MySharedKeys.defaultAddressId));
                          },
                          backgroundColor: AppColors.primary,
                          text: S().saveAndContinue,
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                    ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
