import '../../data/models/search_model.dart';
import '../entity/search_param.dart';

abstract class SearchRepoBase {
  Future<SearchModel> searchData(SearchParam searchParam);
}