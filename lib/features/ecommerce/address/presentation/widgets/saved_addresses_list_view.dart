import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommerce/core/helpers/shared_pref.dart';
import 'package:ecommerce/core/services/navigation/app_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/safe_print.dart';
import '../../../../../core/helpers/shared_pref_keys.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/address_model.dart';
import '../manager/address_cubit.dart';
import '../screens/add_address_screen/address_args.dart';

class SavedAddressesListView extends StatefulWidget {
  const SavedAddressesListView(
      {super.key,
      required this.cubit,
      required this.addressData,
      required this.args});

  final AddressCubit cubit;
  final AddressData addressData;
  final AddressArgs args;

  @override
  State<SavedAddressesListView> createState() => _SavedAddressesListViewState();
}

class _SavedAddressesListViewState extends State<SavedAddressesListView> {
   int selectedIndex=0  ;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state is AddressLoading) {
          const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }
      },
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.addressData.data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  SharedPref.putInt(key: MySharedKeys.defaultAddressId, value: widget.addressData.data[index].id);
                  safePrint(selectedIndex.toString());
                  safePrint(SharedPref.getInt(key: MySharedKeys.defaultAddressId));
                  SharedPref.putString(
                      key: MySharedKeys.city, value: widget.addressData.data[index].city);
                  SharedPref.putString(
                      key: MySharedKeys.addressDetails, value: widget.addressData.data[index].details);

                });
              },
              child: Container(
                padding: EdgeInsets.all(10.sp),
                margin: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: SharedPref.getInt(key: MySharedKeys.defaultAddressId) !=null && selectedIndex == index
                        ? AppColors.primary.withOpacity(0.3)
                        : Colors.transparent,
                    border: Border.all(
                      color: AppColors.greyBorder,
                    )),
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
                        )),
                        IconButton(
                            onPressed: () => Modular.to.pushNamed(AppEndpoints.addAddressScreen,
                                ),
                            icon: const Icon(
                              Icons.edit,
                              color: AppColors.greyBorder,
                            )),
                        IconButton(
                            onPressed: () => awesomeDialog(
                                S().areYouSureYouWantToDeleteThisAddress,
                                context,
                                DialogType.warning,
                                widget.cubit.deleteAddress(
                                    addressId: widget.addressData.data[index].id
                                        .toString())),
                            icon: const Icon(
                              Icons.delete,
                              color: AppColors.red,
                            )),
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
                          widget.addressData.data[index].name,
                          style: TextStyle(fontSize: 16.sp),
                        )),
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
                          widget.addressData.data[index].city,
                          style: TextStyle(fontSize: 16.sp),
                        )),
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
      //desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        click;
      },
    ).show();
  }
}
