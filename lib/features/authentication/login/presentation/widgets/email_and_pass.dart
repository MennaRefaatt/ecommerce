import 'package:ecommerce/core/components/app_text_form_field.dart';
import 'package:ecommerce/core/services/navigation/app_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../manager/login_cubit.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key, required this.cubit});
  final LoginCubit cubit;

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.green,
            ),
          );
          Modular.to.navigate(AppEndpoints.homeScreen);
        }
        if (state is LoginError) {
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
          key: widget.cubit.userDataFormValidators.formKey,
          child: Column(children: [
            AppTextFormField(
                textInputAction: TextInputAction.next,
                withTitle: true,
                controller: widget.cubit.userDataFormValidators.emailController,
                backgroundColor: AppColors.primaryLight,
                keyboardType: TextInputType.emailAddress,
                hintText: "shop@gmail.com",
                title: S().email,
                validator: (value) =>
                    widget.cubit.userDataFormValidators.validateEmail(value!)),
            verticalSpacing(15.h),
            AppTextFormField(
              withTitle: true,
              hintText: "xxxxxxxxx",
              textInputAction: TextInputAction.next,
              title: S().password,
              backgroundColor: AppColors.primaryLight,
              keyboardType: TextInputType.visiblePassword,
              isObscureText: widget.cubit.userDataFormValidators.isPasswordVisible,
              validator: (value) =>
                  widget.cubit.userDataFormValidators.validatePassword(value!),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    widget.cubit.userDataFormValidators.isPasswordVisible =
                        !widget.cubit.userDataFormValidators.isPasswordVisible;
                  });
                },
                icon: Icon(
                  widget.cubit.userDataFormValidators.isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: AppColors.greyBorder,
                ),
              ),
              controller:
                  widget.cubit.userDataFormValidators.passwordController,
            ),
          ]),
        ),
      ),
    );
  }
}
