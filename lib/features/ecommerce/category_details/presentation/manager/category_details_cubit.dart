import 'package:bloc/bloc.dart';
import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/features/ecommerce/category_details/domain/repo_base/repo_base.dart';
import 'package:meta/meta.dart';

import '../../data/model/category_details_model.dart';

part 'category_details_state.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  CategoryDetailsCubit(this.cDetailsRepoBase) : super(CategoryDetailsInitial());
  final CDetailsRepoBase cDetailsRepoBase;

  void getCategoryDetails({required int categoryId}) async {
    emit(CategoryDetailsLoading());
    try {
      final response = await cDetailsRepoBase.getCategoryDetails(
          categoryId: categoryId);
      safePrint(categoryId);
      if (response.status == true) {
        emit(CategoryDetailsSuccess(categoryDetailsModel: response));
      } else {
        emit(CategoryDetailsError(error: response.toString()));
      }
    } catch (e) {
      emit(CategoryDetailsError(error: e.toString()));
    }
  }
}
