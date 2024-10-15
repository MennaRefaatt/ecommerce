import 'package:ecommerce/features/ecommerce/home/data/models/search_model/search_model.dart';
import 'package:ecommerce/features/ecommerce/search/domain/entity/search_param.dart';
import '../../../../../core/helpers/safe_print.dart';
import '../../../../../core/services/network/api_constants.dart';
import '../../../../../core/services/network/api_exceptions.dart';
import '../../../../../core/services/network/api_service.dart';

abstract class DSSearchRemote {
  Future<SearchModel> searchData(SearchParam searchParam);
}

class DSSearchRemoteImpl extends DSSearchRemote {
  DSSearchRemoteImpl();
  @override
  Future<SearchModel> searchData(SearchParam searchParam) async {
    try {
      final response = await ApiService.postData(
        endPoint: EndPoints.search,
        data: searchParam.toJson(),
      );
      safePrint(response.toString());
      final searchModel = SearchModel.fromJson(response);
      return searchModel;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
