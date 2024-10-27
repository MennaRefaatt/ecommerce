import '../../domain/repo_base/repo_base.dart';
import '../data_source/ds_odetails_remote.dart';
import '../model/cancel_order_model.dart';
import '../model/order_details_model.dart';

class ODetailsRepoImpl implements ODetailsRepoBase {
  final DSODetailsRemote dsODetailsRemote;
  ODetailsRepoImpl({required this.dsODetailsRemote});

  @override
  Future<OrderDetailsModel> getOrderDetails({required String id}) async {
    final response = await dsODetailsRemote.getOrderDetails(id: id);
    try {
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CancelOrderModel> cancelOrder({required int orderId}) async {
    final response = await dsODetailsRemote.cancelOrder(orderId: orderId);
    try {
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
