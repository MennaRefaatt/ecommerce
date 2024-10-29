
import 'package:ecommerce/core/helpers/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/cubits/language/language_cubit.dart';
import '../../../../../../core/helpers/safe_print.dart';
import '../../../../../../core/helpers/shared_pref_keys.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../generated/l10n.dart';

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer({super.key});

  @override
  Widget build(BuildContext context) {
     return Container(
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.3),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(21.r),
            topRight: Radius.circular(21.r)),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        mainAxisAlignment:
        MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextButton(
              child: Text(
                S().english,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp),
              ),
              onPressed: () {
                context
                    .read<LanguageCubit>()
                    .changeLanguageToEn();
                Navigator.pop(context);
                safePrint(SharedPref.getString(key: MySharedKeys.currentLanguage));
              }),
          const Divider(
            color: AppColors.primaryLight,
          ),
          TextButton(
              child: Text(
                S().arabic,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp),
              ),
              onPressed: () {
                context
                    .read<LanguageCubit>()
                    .changeLanguageToAr();
                Navigator.pop(context);
                safePrint(SharedPref.getString(key: MySharedKeys.currentLanguage));
              }),
        ],
      ),
         );
  }
}
