import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/core/services/network/api_service.dart';

import '../../../../../../core/services/network/api_constants.dart';
import '../model/cancel_order_model.dart';
import '../model/order_details_model.dart';

abstract class DSODetailsRemote {
  Future<OrderDetailsModel> getOrderDetails({required String id});
  Future<CancelOrderModel> cancelOrder({required int orderId});
}
class DsODetailsRemoteImpl implements DSODetailsRemote {
  DsODetailsRemoteImpl();
  @override
  Future<OrderDetailsModel> getOrderDetails({required String id}) async {
    try {
      final response = await ApiService.getData(endPoint: EndPoints.getOrderDetails + id);
      OrderDetailsModel orderDetailsModel = OrderDetailsModel.fromJson(response);
      safePrint(orderDetailsModel);
      return orderDetailsModel;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<CancelOrderModel> cancelOrder({required int orderId}) async {
    try {
      final response = await ApiService.getData(endPoint: EndPoints.cancelOrder(orderId));
      CancelOrderModel cancelOrderModel = CancelOrderModel.fromJson(response);
      return cancelOrderModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}