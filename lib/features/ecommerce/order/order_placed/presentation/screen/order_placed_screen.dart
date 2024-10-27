import 'package:audioplayers/audioplayers.dart';
import 'package:ecommerce/core/services/navigation/app_endpoints.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce/features/ecommerce/favorite/presentation/manager/favourite_cubit.dart';

import '../../../../../../core/di/di.dart';
import '../../../../../../core/helpers/safe_print.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/utils/app_button.dart';
import '../../../../../../core/utils/app_image.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../home/presentation/manager/home_cubit.dart';
import '../../../order_details/order_details_args.dart';
import '../widgets/products_you_might_like.dart';
class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key, required this.id});
final int id;
  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  final homeCubit = HomeCubit(sl());
  final favoriteCubit = FavouriteCubit(sl());
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playSound();
  }
  void _playSound() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      await _audioPlayer.play(AssetSource('assets/sound/success.mp3'));
    }catch (e) {
      safePrint("Error playing sound: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => homeCubit..getHomeData(),
        ),
        BlocProvider(
          create: (context) => favoriteCubit,
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpacing(20.h),
              AppImage(
                  path: "done.gif",
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover),
              Container(
                margin: EdgeInsets.all(15.sp),
                child: Column(
                  children: [
                    Text(S().orderPlaced,
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold)),
                    verticalSpacing(20.h),
                    Text(S()
                        .yourOrderHasBeenPlacedSuccessfullyProcessedAndIsOnItsWayToYouSoon,
                        style: TextStyle(
                            fontSize: 18.sp, color: AppColors.greyBorder),
                        textAlign: TextAlign.center),
                    verticalSpacing(30.h),
                    AppButton(
                      onPressed: () =>
                          Modular.to.navigate(AppEndpoints.orderDetailsScreen,arguments: OrderDetailsArgs(id: widget.id)),
                      text: S().myOrderDetails,
                      backgroundColor: AppColors.primary,
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    verticalSpacing(10.h),
                    AppButton(
                      onPressed: () =>
                          Modular.to.navigate(AppEndpoints.homeScreen),
                      text: S().continueShopping,
                      textStyle: const TextStyle(
                        color: AppColors.primary,
                      ),
                      backgroundColor: AppColors.primaryLight,
                    ),
                    verticalSpacing(10.h),
                  ],
                ),
              ),
              Divider(
                thickness: 7.sp,
                color: AppColors.greyBorder.withOpacity(0.1),
              ),
              ProductsYouMightLike(favoriteCubit: favoriteCubit,),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
