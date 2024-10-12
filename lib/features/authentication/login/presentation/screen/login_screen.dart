import 'package:ecommerce/core/helpers/spacing.dart';
import 'package:ecommerce/core/services/navigation/app_endpoints.dart';
import 'package:ecommerce/features/authentication/widget/password_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/helpers/safe_print.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/utils/app_button.dart';
import '../../../../../generated/l10n.dart';
import '../manager/login_cubit.dart';
import '../widgets/email_and_pass.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final cubit = LoginCubit(sl());

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
                  S().signInToEShop,
                  style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary),
                ),
              ),
              EmailAndPassword(cubit: cubit),
              PasswordValidations(
                hasLowerCase: cubit.userDataFormValidators.hasLowercase,
                hasUpperCase: cubit.userDataFormValidators.hasUppercase,
                hasSpecialCharacters:
                    cubit.userDataFormValidators.hasSpecialCharacters,
                hasNumber: cubit.userDataFormValidators.hasNumber,
                hasMinLength: cubit.userDataFormValidators.hasMinLength,
              ),
              verticalSpacing(15.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(S().forgotPassword,
                      style: TextStyle(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary,
                          fontSize: 15.sp)),
                ),
              ),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state is LoginSuccess) {
                     Modular.to.navigate(AppEndpoints.homeScreen);
                  }
                  if (state is LoginLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.primary,
                      backgroundColor: Colors.white70,
                    ));
                  } else {
                    return AppButton(
                      backgroundColor: AppColors.primary,
                      onPressed: () {
                        safePrint("clicked");
                        if (cubit.userDataFormValidators.formKey.currentState!
                            .validate()) {
                          cubit.login();
                        }
                      },
                      text: S().signIn,
                      textStyle: TextStyles.font16WhiteSemiBold,
                    );
                  }
                },
              ),
              verticalSpacing(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S().dontHaveAnAccount,
                      style: TextStyle(
                          color: AppColors.greyBorder,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold)),
                  TextButton(
                      onPressed: () {
                        Modular.to.pushNamed(AppEndpoints.register);
                      },
                      child: Text(
                        S().signUp,
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
