import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../core/components/app_text_form_field.dart';
import '../../../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../../../core/theming/app_colors.dart';
import '../../../../../../../../../generated/l10n.dart';
import '../../../../manager/change_password_manager/change_password_cubit.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({required this.cubit, super.key});
  final ChangePasswordCubit cubit;

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpacing(20.h),
          AppTextFormField(
            withTitle: true,
            hintText: "xxxxxxxxx",
            textInputAction: TextInputAction.next,
            title: S().currentPassword,
            backgroundColor: AppColors.primaryLight,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) {
              if (value!.isEmpty) {
                return S().pleaseEnterOldPassword;
              }
              if (value.length < 6) {
                return S().invalidPassword;
              }
              return null;
            },
            suffixIcon: IconButton(
              onPressed: () {
                widget.cubit.obscureText1 = !widget.cubit.obscureText1;
                setState(() {});
              },
              icon: Icon(widget.cubit.obscureText1
                  ? Icons.visibility_off
                  : Icons.visibility),
            ),
            controller: widget.cubit.currentPassController,
          ),
          verticalSpacing(15.h),
          AppTextFormField(
            withTitle: true,
            hintText: "xxxxxxxxx",
            textInputAction: TextInputAction.next,
            title: S().newPassword,
            backgroundColor: AppColors.primaryLight,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) {
              if (value!.isEmpty) {
                return S().pleaseEnterNewPassword;
              }
              if (widget.cubit.currentPassController.text == value) {
                return S().mustBeDifferent;
              }
              if (value.length < 6) {
                return S().invalidPassword;
              }
              return null;
            },
            suffixIcon: IconButton(
              onPressed: () {
                widget.cubit.obscureText3 = !widget.cubit.obscureText3;
                setState(() {});
              },
              icon: Icon(widget.cubit.obscureText3
                  ? Icons.visibility_off
                  : Icons.visibility),
            ),
            controller: widget.cubit.newPassController,
          ),
          verticalSpacing(15.h),
          AppTextFormField(
            textInputAction: TextInputAction.done,
            withTitle: true,
            backgroundColor: AppColors.primaryLight,
            keyboardType: TextInputType.visiblePassword,
            hintText: "xxxxxxxxx",
            title: S().confirmPassword,
            controller: widget.cubit.confirmPasswordController,
            suffixIcon: IconButton(
              onPressed: () {
                widget.cubit.obscureText2 = !widget.cubit.obscureText2;
                setState(() {});
              },
              icon: Icon(widget.cubit.obscureText2
                  ? Icons.visibility_off
                  : Icons.visibility),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return S().pleaseEnterConfirmPassword;
              }
              if (widget.cubit.currentPassController.text == value) {
                return S().mustBeDifferent;
              }
              if (value.length < 6) {
                return S().invalidPassword;
              }
              if (widget.cubit.newPassController.text != value) {
                return S().passwordNotMatch;
              }
              return null;
            },
          ),
          verticalSpacing(15.h),
          BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
            builder: (context, state) {
              if (state is ChangePasswordLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              } else {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    minimumSize: Size(double.infinity, 50.sp),
                  ),
                  onPressed: () {
                    if (widget.cubit.formKey.currentState!.validate()) {
                      widget.cubit.changePassword();
                    }
                  },
                  child: Text(
                    S().changePassword,
                    style: TextStyle(
                        color: AppColors.primaryLight, fontSize: 18.sp),
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
