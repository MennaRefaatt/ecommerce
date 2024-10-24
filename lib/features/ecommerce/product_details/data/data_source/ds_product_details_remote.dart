import 'package:ecommerce/core/helpers/safe_print.dart';

import '../../../../../core/services/network/api_constants.dart';
import '../../../../../core/services/network/api_service.dart';
import '../model/product_details_model.dart';

abstract class DSProductDetailsRemote {
  Future<ProductDetailsModel> getProductDetails({required int productId});
}

class DSProductDetailsRemoteImpl implements DSProductDetailsRemote {
  DSProductDetailsRemoteImpl();
  @override
  Future<ProductDetailsModel> getProductDetails(
      {required int productId}) async {
    try {
      final response = await ApiService.getData(
        endPoint: EndPoints.productDetails + productId.toString());
safePrint(response);
      ProductDetailsModel productDetailsModel =
          ProductDetailsModel.fromJson(response);
      safePrint(productDetailsModel);
      return productDetailsModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
