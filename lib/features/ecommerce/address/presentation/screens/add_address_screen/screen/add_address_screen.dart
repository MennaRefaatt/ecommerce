import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/components/app_bar.dart';
import '../../../../../../../core/di/di.dart';
import '../../../../../../../core/helpers/safe_print.dart';
import '../../../../../../../core/theming/app_colors.dart';
import '../../../../../../../core/utils/app_button.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../../maps/presentation/manager/location_cubit.dart';
import '../../../manager/address_cubit.dart';
import '../widgets/address_data_entry.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({
    super.key,
  });
  final cubit = AddressCubit(sl());
  final mapsCubit = LocationCubit(sl(), sl(), sl());
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => cubit,
        ),
        BlocProvider(
          create: (context) => mapsCubit,
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultAppBar(
                  text: S().addNewAddress, cartIcon: false, backArrow: true),
              Container(
                margin: EdgeInsets.all(15.sp),
                child: Column(
                  children: [
                    AddressDataEntry(
                      cubit: cubit,
                    ),
                    BlocBuilder<AddressCubit, AddressState>(
                      builder: (context, state) {
                        if (state is AddressLoading) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.primary,
                            backgroundColor: Colors.white70,
                          ));
                        } else {
                          return Center(
                            child: AppButton(
                              backgroundColor: AppColors.primary,
                              onPressed: () {
                                if (cubit.addressData.isEmpty) {
                                  if (cubit.formKey.currentState!.validate()) {
                                    cubit.addAddressWithSelectedLocation(mapsCubit);
                                    Modular.to.pop();
                                  }
                                  safePrint("======> ${cubit.addressData.last.lat+cubit.addressData.last.long}");
                                } else {
                                  safePrint("No address found to save");
                                }
                              },
                              text: S().save,
                              textStyle: TextStyle(
                                fontSize: 20.sp,
                                color: AppColors.primaryLight,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
