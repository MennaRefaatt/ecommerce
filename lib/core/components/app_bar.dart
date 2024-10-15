
import 'package:ecommerce/core/utils/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/navigation/app_endpoints.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar(
      {super.key, required this.text, required this.cartIcon,required this.backArrow});
  final String text;
  final bool? cartIcon;
  final bool? backArrow;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.h,
      padding: EdgeInsets.all(15.sp),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: backArrow == true,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Visibility(
              visible: cartIcon == true,
              child: InkWell(
                  onTap: () => Modular.to.pushNamed(AppEndpoints.cartScreen),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  child: const AppSvg(path: "shopping-cart"))),
        ],
      ),
    );
  }
}
