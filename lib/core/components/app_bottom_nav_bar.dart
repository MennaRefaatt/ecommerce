import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/core/services/navigation/app_endpoints.dart';
import 'package:ecommerce/core/theming/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onTap: (index) {
          safePrint(index);
          if (index == 0) {
            Modular.to.navigate(AppEndpoints.homeScreen);
          }
          if (index == 1) {
            Modular.to.navigate(AppEndpoints.ordersScreen);
          }
          if (index == 2) {
            Modular.to.navigate(AppEndpoints.favoriteScreen);
          }
          if (index == 3) {
            Modular.to.navigate(AppEndpoints.settingsScreen);
          }
        },
        currentIndex: index,
        selectedLabelStyle: TextStyle(fontSize: 12.sp),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        showSelectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_alt),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bag),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: "Profile",
          ),
        ]);
  }
}
