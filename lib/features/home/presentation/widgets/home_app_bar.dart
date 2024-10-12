import 'package:ecommerce/core/utils/app_image.dart';
import 'package:ecommerce/core/utils/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/navigation/app_endpoints.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';


class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
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
             backgroundColor: AppColors.greyInput,
              child:  AppSvg(
                path: "shopping-cart",
                width: 20.w,
                height: 20.h,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
