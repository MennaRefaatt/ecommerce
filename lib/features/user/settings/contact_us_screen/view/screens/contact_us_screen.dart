
import 'package:ecommerce/core/components/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/components/app_bar.dart';
import '../../../../../../core/helpers/safe_print.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../manager/contact_us_cubit.dart';
class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});

  final cubit = ContactUsCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getContactUs(),
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.2),
        body: SingleChildScrollView(
          child: Column(
            children: [
              DefaultAppBar(
                  text: S().contactUs, cartIcon: false, backArrow: true),
              BlocBuilder<ContactUsCubit, ContactUsState>(
                builder: (context, state) {
                  if (state is ContactUsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  } else if (state is ContactUsSuccess) {
                    return Container(
                      margin: EdgeInsets.all(15.sp),
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.contactUsModel.data!.data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(20.sp),
                            onTap: () {
                              safePrint(
                                  "value ${state.contactUsModel.data!.data[index].value}");
                              launchUrl(Uri.parse(state
                                  .contactUsModel.data!.data[index].value));
                              //launch(state.contactUsModel.data!.data[index].value);
                            },
                            child: AppNetworkImage(
                                imageUrl: state
                                    .contactUsModel.data!.data[index].image,
                                width: 1.w,
                                height: 50.h,
                                borderRadius: BorderRadius.circular(10.sp)),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 40.sp,
                          crossAxisSpacing: 40.sp,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
