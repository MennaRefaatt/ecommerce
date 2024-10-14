import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/components/app_network_image.dart';
import '../../../../../core/components/app_text_form_field.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/services/navigation/app_endpoints.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../manager/search_cubit.dart';

class SearchScreen extends StatelessWidget {

  SearchScreen({super.key});

  final SearchCubit searchCubit = SearchCubit(sl());
  final FocusNode searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(searchFocusNode);
    });
    return BlocProvider(
      create: (context) => searchCubit,
      child: SafeArea(
        child: Scaffold(
          body: BlocListener<SearchCubit, SearchState>(
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
                      SizedBox(height: 34.h),
                      Padding(
                        padding: EdgeInsets.all(15.sp),
                        child: AppTextFormField(
                          focusNode: searchFocusNode,
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
                          onChanged: searchCubit.onSearchChanged,
                        ),
                      ),
                      if (state is SearchLoading)
                        const Center(
                            child:
                                CircularProgressIndicator(color: AppColors.primary))
                      else if (state is SearchSuccess)
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: searchCubit.searchDataList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Modular.to.pushNamed(
                                  AppEndpoints.productDetailsScreen,
                                  // arguments: ProductDetailsArgs(
                                  //   id: searchDataList[index].id,
                                  // )
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                                child: ListTile(
                                  leading: AppNetworkImage(
                                      imageUrl: searchCubit.searchDataList[index].image.toString()),
                                  title: Text(searchCubit.searchDataList[index].name.toString()),
                                  subtitle:
                                      Text(searchCubit.searchDataList[index].price.toString()),
                                ),
                              );
                            })
                      else if (state is SearchError)
                        Center(child: Text('Error: ${state.error}')),
                    ],
                  ),
                );
              },
            ),
            )),
      )
        );

  }
}
