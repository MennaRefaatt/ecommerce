import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/categories_model.dart';
import '../../domain/repo_base/repo_base.dart';
part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.categoriesRepo) : super(CategoriesInitial());
  final CategoriesRepoBase categoriesRepo;

  Future<void> getCategoriesData() async {
    emit(CategoriesLoading());
    try {
      final response = await categoriesRepo.getCategoriesData();
      if (response.status == true) {
        emit(CategoriesSuccess(categoriesModel: response));
      } else {
        emit(CategoriesFailure(error: response.toString()));
      }
    } catch (e) {
      emit(CategoriesFailure(error: e.toString()));
    }
  }
}
