import '../../../home/data/models/search_model/search_model.dart';
import '../entity/search_param.dart';

abstract class SearchRepoBase {
  Future<SearchModel> searchData(SearchParam searchParam);
}