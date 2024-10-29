import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../core/components/app_text_form_field.dart';
import '../../../../../../../../../core/helpers/shared_pref.dart';
import '../../../../../../../../../core/helpers/shared_pref_keys.dart';
import '../../../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../../../core/theming/app_colors.dart';
import '../../../../../../../../../core/utils/app_button.dart';
import '../../../../../../../../../generated/l10n.dart';
import '../../../../manager/update_account_manager/update_account_cubit.dart';

class UpdateAccountForm extends StatelessWidget {
  final UpdateAccountCubit cubit;

  UpdateAccountForm({super.key, required this.cubit}) {
    cubit.nameController.text = SharedPref.getString(key: MySharedKeys.userName) ?? '';
    cubit.phoneController.text = SharedPref.getString(key: MySharedKeys.phone) ?? '';
    cubit.emailController.text = SharedPref.getString(key: MySharedKeys.email) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpacing(20.h),
          AppTextFormField(
            withTitle: true,
            textInputAction: TextInputAction.next,
            controller: cubit.nameController,
            backgroundColor: AppColors.primaryLight,
            keyboardType: TextInputType.name,
            hintText: SharedPref.getString(key: MySharedKeys.userName),
            title: S().name,
            focusNode: FocusNode()
              ..addListener(() {
                if (cubit.nameController.selection.baseOffset == -1) {
                  cubit.nameController.selection = TextSelection.fromPosition(
                    TextPosition(offset: cubit.nameController.text.length),
                  );
                }
              }),
            validator: (value) {
              if (value!.isEmpty) return S().pleaseEnterYourName;
              return null;
            },
          ),
          verticalSpacing(15.h),
          AppTextFormField(
            withTitle: true,
            textInputAction: TextInputAction.next,
            controller: cubit.phoneController,
            backgroundColor: AppColors.primaryLight,
            keyboardType: TextInputType.phone,
            hintText: SharedPref.getString(key: MySharedKeys.phone),
            title: S().phone,
            focusNode: FocusNode()
              ..addListener(() {
                if (cubit.phoneController.selection.baseOffset == -1) {
                  cubit.phoneController.selection = TextSelection.fromPosition(
                    TextPosition(offset: cubit.phoneController.text.length),
                  );
                }
              }),
            validator: (value) {
              if (value!.isEmpty) return S().pleaseEnterYourPhone;
              if (!value.contains('01')) return S().invalidPhone;
              if (value.length != 11) return S().lengthMustBeEqual11;
              return null;
            },
            maxLength: 11,
          ),
          verticalSpacing(15.h),
          AppTextFormField(
            textInputAction: TextInputAction.done,
            withTitle: true,
            controller: cubit.emailController,
            backgroundColor: AppColors.greyBorder,
            keyboardType: TextInputType.emailAddress,
            enable: false,
            title: SharedPref.getString(key: MySharedKeys.email)!,
          ),
          verticalSpacing(15.h),
          BlocBuilder<UpdateAccountCubit, UpdateAccountState>(
            builder: (context, state) {
              if (state is UpdateAccountLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              } else {
                return Center(
                  child: AppButton(
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.updateAccount();
                      }
                    },
                    text: S().updateAccount,
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
    );
  }
}
