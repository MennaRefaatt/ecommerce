import '../../domain/repo_base/repo_base.dart';
import '../data_source/ds_orders_remote.dart';
import '../model/orders_model.dart';

class OrdersRepoImpl extends OrdersRepoBase {
  final DSOrdersRemote dsOrdersRemote;
  OrdersRepoImpl({required this.dsOrdersRemote});
  @override
  Future<OrdersModel> getOrders() async {
    final response = await dsOrdersRemote.getOrders();
    try {
      return response;
    } catch (e) {
      rethrow;
    }
  }
}