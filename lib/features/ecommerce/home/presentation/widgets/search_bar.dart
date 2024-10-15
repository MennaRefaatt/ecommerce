import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/components/app_text_form_field.dart';
import '../../../../../core/services/navigation/app_endpoints.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../search/presentation/manager/search_cubit.dart';

class SearchBarr extends StatelessWidget {
  const SearchBarr({
    super.key,
    required this.searchCubit,
  });

  final SearchCubit searchCubit;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is SearchLoading) {
          const Center(
              child: CircularProgressIndicator(color: AppColors.primary));
        } else if (state is SearchSuccess) {
          searchCubit.searchDataList = state.searchModel.data?.searchDataList ?? [];
        } else if (state is SearchError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15.sp),
                  child: GestureDetector(
                    onTap: () {
                      Modular.to.pushNamed(AppEndpoints.searchScreen);
                    },
                    child: AppTextFormField(
                      enable: false,
                      contentPadding: EdgeInsets.all(10.sp),
                      borderRadius: BorderRadius.circular(30.r),
                      backgroundColor: Colors.white,
                      isFilled: true,
                      hintText: S().search,
                      title: S().search,
                      controller: searchCubit.searchController,
                      suffixIcon: Container(
                        margin: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              searchCubit.searchData();
                            },
                            icon: Icon(
                              CupertinoIcons.search,
                              size: 24.sp,
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
