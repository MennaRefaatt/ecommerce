import '../../data/model/orders_model.dart';

abstract class OrdersRepoBase {
  Future<OrdersModel> getOrders();
}