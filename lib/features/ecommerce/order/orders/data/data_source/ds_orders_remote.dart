
import '../../../../../../core/services/network/api_constants.dart';
import '../../../../../../core/services/network/api_service.dart';
import '../model/orders_model.dart';

abstract class DSOrdersRemote {
  Future<OrdersModel> getOrders();
}

class DSOrdersRemoteImpl extends DSOrdersRemote {
  DSOrdersRemoteImpl();
  @override
  Future<OrdersModel> getOrders() async {
    final response = await ApiService.getData(endPoint: EndPoints.getOrders);
    try {
      OrdersModel ordersModel = OrdersModel.fromJson(response);
      return ordersModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
