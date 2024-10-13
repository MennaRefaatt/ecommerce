import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../home/data/models/search_model/search_model.dart';
import '../../domain/entity/search_param.dart';
import '../../domain/usecase/search_usecase.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchUseCase) : super(SearchInitial());
  final SearchUseCase searchUseCase;
  final searchController = TextEditingController();
  List<SearchDataList> searchDataList = [];
  Timer? _debounce;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        searchData();
      } else {
        emit(SearchInitial());
      }
    });
  }

  void searchData() async {
    emit(SearchLoading());
    final result =
        await searchUseCase.execute(SearchParam(text: searchController.text));
    if (result.status == true) {
      safePrint(result);
      emit(SearchSuccess(searchModel: result));
    } else {
      emit(SearchError(error: result.toString()));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
