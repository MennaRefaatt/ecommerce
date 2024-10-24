import '../../data/models/search_model.dart';
import '../entity/search_param.dart';
import '../repo_base/search_repo_base.dart';

class SearchUseCase {
  final SearchRepoBase searchRepoBase;
  SearchUseCase({required this.searchRepoBase});

  Future<SearchModel> execute(SearchParam searchParam) async {
    return searchRepoBase.searchData(searchParam);
  }
}