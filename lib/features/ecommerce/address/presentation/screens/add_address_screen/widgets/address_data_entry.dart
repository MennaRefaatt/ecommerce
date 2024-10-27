
import 'package:ecommerce/core/components/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../core/theming/app_colors.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../manager/address_cubit.dart';

class AddressDataEntry extends StatelessWidget {
  const AddressDataEntry(
      {super.key, required this.cubit,});
  final AddressCubit cubit;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state is AddressSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.addressModel.message),
              backgroundColor: AppColors.green,
            ),
          );
        }
        if (state is AddressError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red[900],
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.all(15.sp),
        child: Form(
          key: cubit.formKey,
          child: Column(children: [
            AppTextFormField(
              withTitle: true,
              textInputAction: TextInputAction.next,
              controller: cubit.nameController,
              backgroundColor: AppColors.primaryLight,
              keyboardType: TextInputType.name,
              hintText: "Your name",
              title: S().name,
              isFilled: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return S().pleaseEnterYourName;
                }
                return null;
              },
            ),
            verticalSpacing(15.h),
            AppTextFormField(
              isFilled: true,
              withTitle: true,
              textInputAction: TextInputAction.next,
              controller: cubit.cityController,
              backgroundColor: AppColors.primaryLight,
              keyboardType: TextInputType.name,
              hintText: "city",
              title: S().city,
              validator: (value) {
                if (value!.isEmpty) {
                  return S().required;
                }
                return null;
              },
            ),
            verticalSpacing(15.h),
            AppTextFormField(
              withTitle: true,
              isFilled: true,
              textInputAction: TextInputAction.next,
              controller: cubit.regionController,
              backgroundColor: AppColors.primaryLight,
              keyboardType: TextInputType.number,
              hintText: "region",
              title: S().region,
              validator: (value) {
                if (value!.isEmpty) {
                  return S().required;
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                if(value.startsWith('0')) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            verticalSpacing(15.h),
            AppTextFormField(
              withTitle: true,
              isFilled: true,
              textInputAction: TextInputAction.next,
              controller: cubit.detailsController,
              backgroundColor: AppColors.primaryLight,
              keyboardType: TextInputType.name,
              hintText: "details",
              title: S().details,
              validator: (value) {
                if (value!.isEmpty) {
                  return S().required;
                }
                return null;
              },
            ),
            verticalSpacing(15.h),
            AppTextFormField(
              isFilled: true,
              withTitle: true,
              textInputAction: TextInputAction.next,
              controller: cubit.notesController,
              backgroundColor: AppColors.primaryLight,
              keyboardType: TextInputType.name,
              hintText: "notes",
              title: S().notes,
            ),
            verticalSpacing(15.h),
          ]),
        ),
      ),
    );
  }
}
