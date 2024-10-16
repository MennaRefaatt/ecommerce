
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/components/app_bar.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../manager/terms_and_conditions_cubit.dart';

class TermsAndConditionsScreen extends StatelessWidget {
   TermsAndConditionsScreen({super.key});
final cubit=TermsAndConditionsCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getTermsAndConditions(),
      child: BlocBuilder<TermsAndConditionsCubit, TermsAndConditionsState>(
        builder: (context, state) {
          if (state is TermsAndConditionsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }
      if (state is  TermsAndConditionsSuccess) {
        return Scaffold(
        body: Column(
          children: [
            DefaultAppBar(text: S().termsAndConditions, cartIcon: false, backArrow: true),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(15.sp),
                child:  Column(
                      children: [
                        Text(state.termsAndConditionsModel.data!.about,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
                        verticalSpacing(15.h),
                        Divider(
                          color: Colors.grey,
                          thickness: 1.h,
                        ),
                        verticalSpacing(15.h),
                        Text(state.termsAndConditionsModel.data!.terms,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
                      ],
                    )
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
      },
      ),
    );
  }
}
