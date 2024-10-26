import 'package:ecommerce/core/services/network/api_service.dart';

import '../../../../../core/helpers/safe_print.dart';
import '../../../../../core/services/network/api_constants.dart';
import '../model/categories_model.dart';

abstract class DsCategoriesRemote {
  Future<CategoriesModel> getCategoriesData();
}
class DsCategoriesRemoteImpl extends DsCategoriesRemote {
  DsCategoriesRemoteImpl();
  @override
  Future<CategoriesModel> getCategoriesData() async {
    final response = await ApiService.getData(endPoint: EndPoints.categories);
    try {
      safePrint(response);
      CategoriesModel categoriesModel = CategoriesModel.fromJson(response);
      return categoriesModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}