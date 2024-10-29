
import 'package:ecommerce/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/components/app_bar.dart';
import '../../../../../../core/components/app_text_form_field.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/utils/app_button.dart';
import '../../../../../../generated/l10n.dart';
import '../manager/complaints_cubit.dart';

class ComplaintsScreen extends StatelessWidget {
  ComplaintsScreen({super.key});
  final cubit = ComplaintsCubit(sl());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        body: Column(
          children: [
            DefaultAppBar(
                text: S().complaints, cartIcon: false, backArrow: true),
            Container(
              margin: EdgeInsets.all(15.sp),
              child: BlocBuilder<ComplaintsCubit, ComplaintsState>(
                builder: (context, state) {
                  if (state is ComplaintsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Form(
                        key: cubit.userDataFormValidators.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextFormField(
                              withTitle: true,
                              textInputAction: TextInputAction.next,
                              //backgroundColor: AppColors.primaryLight,
                              keyboardType: TextInputType.name,
                              hintText: S().name,
                              title: S().name,
                              controller: cubit.userDataFormValidators.nameController,
                              backgroundColor: AppColors.greyInput,
                              validator: (value) => cubit.userDataFormValidators.validateName(value),
                            ),
                            verticalSpacing(15.h),
                            AppTextFormField(
                              hintText: "01XXXXXXXXX",
                              keyboardType: TextInputType.phone,
                              maxLength: 11,
                              withTitle: true,
                              //backgroundColor: AppColors.primaryLight,
                              textInputAction: TextInputAction.next,
                              backgroundColor: AppColors.greyInput,
                              validator: (value) => cubit.userDataFormValidators.validatePhone(value),
                              title: S().phone,
                              controller: cubit.userDataFormValidators.phoneController,
                            ),
                            verticalSpacing(15.h),
                            AppTextFormField(
                                textInputAction: TextInputAction.next,
                                withTitle: true,
                                //backgroundColor: AppColors.primaryLight,
                                keyboardType: TextInputType.emailAddress,
                                hintText: "shop@gmail.com",
                                title: S().email,
                                controller: cubit.userDataFormValidators.emailController,
                                backgroundColor: AppColors.greyInput,
                                validator: (value) => cubit.userDataFormValidators.validateEmail(value)),
                            verticalSpacing(15.h),
                            AppTextFormField(
                                maxLines: 5,
                                minLines: 3,
                                keyboardType: TextInputType.multiline,
                                //backgroundColor: AppColors.primaryLight,
                                textInputAction: TextInputAction.done,
                                hintText: S().writeYourComplaintHere,
                                withTitle: true,
                                title: S().writeYourComplaintHere,
                                controller: cubit.messageController,
                                isFilled: true,
                                backgroundColor: AppColors.greyInput,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S().writeYourComplaintHere;
                                  }
                                  return null;
                                }),
                            verticalSpacing(15.h),
                            Center(
                              child: AppButton(
                                  onPressed: () {
                                    if (cubit.userDataFormValidators.formKey.currentState!.validate()) {
                                      cubit.sendComplaints();
                                      SnackBar(
                                        content: Text(state.toString()),
                                        backgroundColor: AppColors.primary,
                                        duration: const Duration(seconds: 2),
                                      );
                                      Modular.to.pop(context);
                                    }
                                  },
                                  backgroundColor: AppColors.primary,
                                  text: S().complaints,
                                textStyle: TextStyles.font14WhiteRegular,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
