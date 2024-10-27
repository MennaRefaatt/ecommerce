import 'package:ecommerce/core/helpers/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/shared_pref_keys.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../address/presentation/manager/address_cubit.dart';

class DefaultAddress extends StatelessWidget {
  const DefaultAddress({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(builder: (context, state) {
      if (state is AddressLoading) {
        return const Center(
            child: CircularProgressIndicator(
          color: AppColors.primary,
        ));
      } else if (state is AddressError) {
        return Center(child: Text(state.error));
      } else if (state is AddressSuccess) {
        final addressList = state.addressModel.addressData;
        if (addressList == null) {
          return const Center(child: Text('No address found'));
        } else {
          return Padding(
            padding: EdgeInsets.all(15.sp),
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.location,
                  color: AppColors.primary,
                ),
                horizontalSpacing(20.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SharedPref.getString(key: MySharedKeys.city)!,
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    verticalSpacing(5.sp),
                    Text(
                      SharedPref.getString(key: MySharedKeys.addressDetails)!,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      } else {
        return Container();
      }
    });
  }
}
