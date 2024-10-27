import '../../data/model/cancel_order_model.dart';
import '../../data/model/order_details_model.dart';

abstract class ODetailsRepoBase {
  Future<OrderDetailsModel> getOrderDetails({required String id});
  Future<CancelOrderModel> cancelOrder({required int orderId});
}