import 'package:ecommerce/features/ecommerce/category_details/data/model/category_details_model.dart';

import '../../../../../core/services/network/api_constants.dart';
import '../../../../../core/services/network/api_service.dart';

abstract class DsCDetailsRemote {
  Future<CategoryDetailsModel> getCDetailsData({required int categoryId});
}
class DsCDetailsRemoteImpl extends DsCDetailsRemote {
  DsCDetailsRemoteImpl();
  @override
  Future<CategoryDetailsModel> getCDetailsData({required int categoryId}) async {
    final response = await ApiService.getData(endPoint: EndPoints.categoryDetails+categoryId.toString());
    try {
      CategoryDetailsModel cDetailsModel = CategoryDetailsModel.fromJson(response);
      return cDetailsModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}