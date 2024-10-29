import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/ecommerce/order/orders/domain/repo_base/repo_base.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../data/model/orders_model.dart';
part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.ordersRepoBase) : super(OrdersInitial());
  final OrdersRepoBase ordersRepoBase;

  void getOrders() async {
    emit(OrdersLoading());
    try {
      final response = await ordersRepoBase.getOrders();
      if (response.status == true) {
        List<OrderDataList> currentOrders = [];
        List<OrderDataList> oldOrders = [];

        for (var order in response.data.data) {
          if (order.status == "New" || order.status == "جديد") {
            currentOrders.add(order);
          } else if (order.status == "Cancelled" ||
              order.status == "delivered" ||
              order.status == "ملغي") {
            oldOrders.add(order);
          }
        }
        emit(OrdersSuccess(currentOrders: currentOrders, oldOrders: oldOrders));
      } else {
        emit(OrdersError(error: response.toString()));
      }
    } catch (e) {
      emit(OrdersError(error: e.toString()));
    }
  }
}
