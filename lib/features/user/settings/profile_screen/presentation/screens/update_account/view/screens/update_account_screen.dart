import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../core/components/app_bar.dart';
import '../../../../../../../../../core/di/di.dart';
import '../../../../../../../../../core/theming/app_colors.dart';
import '../../../../../../../../../generated/l10n.dart';
import '../../../../manager/update_account_manager/update_account_cubit.dart';
import '../widgets/update_account_form.dart';

class UpdateAccountScreen extends StatelessWidget {
  UpdateAccountScreen({super.key});

  final cubit = UpdateAccountCubit(sl());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<UpdateAccountCubit, UpdateAccountState>(
        listener: (context, state) {
          if (state is UpdateAccountError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.red,
                content: Text(state.error),
              ),
            );
          }
          if (state is UpdateAccountSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.green,
                content: Text(S().done),
              ),
            );
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                DefaultAppBar(
                    text: S().profileInfo, cartIcon: false, backArrow: true),
                Container(
                  margin: EdgeInsets.all(15.sp),
                  padding: EdgeInsets.all(15.sp),
                  child: UpdateAccountForm(cubit: cubit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
