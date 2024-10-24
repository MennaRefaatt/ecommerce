
import '../../../../../core/helpers/safe_print.dart';
import '../../domain/entity/search_param.dart';
import '../../domain/repo_base/search_repo_base.dart';
import '../data_source/ds_search_remote.dart';
import '../models/search_model.dart';

class SearchRepoImpl implements SearchRepoBase {
  final DSSearchRemote dsSearchRemote;
  SearchRepoImpl({
    required this.dsSearchRemote,
  });

  @override
  Future<SearchModel> searchData(SearchParam searchParam) async {
    final response = await dsSearchRemote.searchData(searchParam);
    safePrint("=======$response");
    if (response.status == true) {
      return response;
    } else {
      throw Exception("Failed to fetch search data");
    }
  }
}
