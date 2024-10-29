import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommerce/core/helpers/shared_pref.dart';
import 'package:ecommerce/core/services/navigation/app_endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce/core/helpers/shared_pref_keys.dart';
import 'package:ecommerce/core/helpers/spacing.dart';
import 'package:ecommerce/core/theming/app_colors.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/features/ecommerce/address/data/model/address_model.dart';
import 'package:ecommerce/features/ecommerce/address/presentation/manager/address_cubit.dart';
import 'package:ecommerce/features/ecommerce/address/presentation/screens/add_address_screen/address_args.dart';

class SavedAddressesListView extends StatefulWidget {
  const SavedAddressesListView({
    super.key,
    required this.cubit,
    required this.addressData,
    required this.args,
  });

  final AddressCubit cubit;
  final AddressData addressData;
  final AddressArgs args;

  @override
  State<SavedAddressesListView> createState() => _SavedAddressesListViewState();
}

class _SavedAddressesListViewState extends State<SavedAddressesListView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final recentAddresses = widget.addressData.data.toList().take(2).toList();
    return BlocListener<AddressCubit, AddressState>(
      listener: (context, state) {},
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: recentAddresses.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final address = recentAddresses[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.all(10.sp),
                margin: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: SharedPref.getInt(key: MySharedKeys.defaultAddressId) ==
                      address.id
                      ? AppColors.primary.withOpacity(0.3)
                      : Colors.transparent,
                  border: Border.all(
                    color: AppColors.greyBorder,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            S().address,
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Modular.to.pushNamed(
                            AppEndpoints.addAddressScreen,
                          ),
                          icon: const Icon(
                            Icons.edit,
                            color: AppColors.greyBorder,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            widget.cubit.deleteAddress(
                              addressId: address.id.toString(),
                            );
                            awesomeDialog(
                              S().areYouSureYouWantToDeleteThisAddress,
                              context,
                              DialogType.warning,
                              widget.cubit.deleteAddress(
                                  addressId: address.id.toString()));
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: AppColors.red,
                          ),
                        ),
                      ],
                    ),
                    verticalSpacing(10.h),
                    Row(
                      children: [
                        const Icon(
                          Icons.person_2_outlined,
                          color: AppColors.primary,
                        ),
                        Expanded(
                          child: Text(
                            address.name,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                    verticalSpacing(10.h),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.primary,
                        ),
                        Expanded(
                          child: Text(
                            address.city,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                    verticalSpacing(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Set as Default',
                          style: TextStyle(fontSize: 16.sp,),
                        ),
                        CupertinoSwitch(
                          value: SharedPref.getInt(
                              key: MySharedKeys.defaultAddressId) ==
                              address.id,
                          onChanged: (bool value) {
                            setState(() {
                              selectedIndex = index;
                              SharedPref.putInt(
                                  key: MySharedKeys.defaultAddressId,
                                  value: address.id);
                              SharedPref.putString(
                                  key: MySharedKeys.city, value: address.city);
                              SharedPref.putString(
                                  key: MySharedKeys.addressDetails,
                                  value: address.details);

                            });
                          },
                          activeColor: AppColors.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void awesomeDialog(
      String message, BuildContext context, DialogType type, click) {
    AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.rightSlide,
      barrierColor: Colors.white54,
      btnCancelColor: AppColors.primary,
      btnOkColor: Colors.red[900],
      btnOkText: "Yes",
      dialogBackgroundColor: Colors.white70,
      title: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        click;
        Modular.to.pop();
      },
    ).show();
  }
}
