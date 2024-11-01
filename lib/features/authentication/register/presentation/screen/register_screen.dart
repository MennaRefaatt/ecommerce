import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/utils/app_button.dart';
import '../../../../../generated/l10n.dart';
import '../manager/register_cubit.dart';
import '../widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final cubit = RegisterCubit(sl());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpacing(150.h),
            Center(
              child: Text(
                S().signUp,
                style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary),
              ),
            ),
            RegisterForm(cubit: cubit),
            verticalSpacing(15.h),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                if (state is RegisterLoadingState) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.primary,
                    backgroundColor: Colors.white70,
                  ));
                } else {
                  return AppButton(
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      if (cubit.userDataFormValidators.formKey.currentState!
                          .validate()) {
                        cubit.register();
                      }
                    },
                    text: S().register,
                    textStyle: const TextStyle(color: AppColors.primaryLight),
                  );
                }
              },
            ),
            verticalSpacing(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S().iAlreadyHaveAnAccount,
                  style: TextStyle(
                      color: AppColors.greyBorder,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Modular.to.pop();
                    },
                    child: Text(
                      S().signIn,
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            )
          ],
        ),
      )),
    );
  }
}
