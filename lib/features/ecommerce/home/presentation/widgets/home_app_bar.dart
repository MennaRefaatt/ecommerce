import 'package:ecommerce/core/utils/app_image.dart';
import 'package:ecommerce/core/utils/app_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/safe_print.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/services/navigation/app_endpoints.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/theming_manager.dart';
import '../../../../../generated/l10n.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});
  //final ThemeManager _themeManager = ThemeManager();
  @override
  Widget build(BuildContext context) {
    final themeCubit =
        BlocProvider.of<ThemeCubit>(context); // Get the ThemeCubit instance
    return Container(
      margin: EdgeInsets.only(left: 15.sp, right: 15.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          AppImage(
            path: "app_icon2.png",
            width: 40.w,
            height: 40.h,
            fit: BoxFit.fill,
          ),
          Expanded(
              child: Text(
            S().eShop,
            style: TextStyle(
                color: AppColors.primary,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          )),
          InkWell(
            onTap: () => Modular.to.navigate(AppEndpoints.cartScreen),
            borderRadius: BorderRadius.circular(30.sp),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              child: AppSvg(
                path: "shopping-cart",
                width: 20.w,
                height: 20.h,
                color: AppColors.primary,
              ),
            ),
          ),
          horizontalSpacing(10.sp),
          InkWell(
              borderRadius: BorderRadius.circular(30.sp),
              onTap: () => Modular.to.pushNamed(AppEndpoints.chatScreen),
              child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  child: const Icon(
                    CupertinoIcons.chat_bubble_2,
                    color: AppColors.primary,
                  ))),
          horizontalSpacing(10.sp),
          CircleAvatar(
            backgroundColor: Theme.of(context).iconTheme.color,
            child: IconButton(
                onPressed: () {
                  themeCubit.toggleTheme();
                  safePrint("dark mode = ${themeCubit.isDarkMode}");
                },
                icon: Icon(
                  themeCubit.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).colorScheme.onPrimary,
                )),
          ),
        ],
      ),
    );
  }
}
