import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/components/app_bar.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/services/navigation/app_endpoints.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../../settings_screen/view/widgets/ink_well_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(text: S().profile, cartIcon: false, backArrow: true),
          Container(
            margin: EdgeInsets.all(15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpacing(20.h),
                inkWell(
                    icon: Icons.person_2_outlined,
                    text: S().profileInfo,
                    context: context,
                    onTap: () =>
                        Modular.to.pushNamed(AppEndpoints.updateAccountScreen)),
                verticalSpacing(25.h),
                Divider(
                  color: AppColors.primary,
                  thickness: 1.sp,
                ),
                verticalSpacing(25.h),
                inkWell(
                  icon: Icons.lock_open,
                  text: S().changePassword,
                  context: context,
                  onTap: () => Modular.to.pushNamed( AppEndpoints.changePassword),
                ),
                verticalSpacing(50.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
