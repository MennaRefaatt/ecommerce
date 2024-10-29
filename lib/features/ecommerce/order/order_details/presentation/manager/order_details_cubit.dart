import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/ecommerce/order/order_details/domain/repo_base/repo_base.dart';
import 'package:meta/meta.dart';
import '../../data/model/cancel_order_model.dart';
import '../../data/model/order_details_model.dart';
part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit(this.oDetailsRepoBase) : super(OrderDetailsInitial());
  final ODetailsRepoBase oDetailsRepoBase;
  void getOrderDetails({required String id}) async {
    emit(OrderDetailsLoading());
    final response = await oDetailsRepoBase.getOrderDetails(id: id);
    if (response.status == true) {
      emit(OrderDetailsSuccess(
        orderDetailsModel: response,
      ));
    } else {
      emit(OrderDetailsError(error: response.message.toString()));
    }
  }

  cancelOrder({required int orderId}) async {
    emit(CancelOrderLoading());
    final response = await oDetailsRepoBase.cancelOrder(orderId: orderId);
    if (response.status == true) {
      emit(CancelOrderSuccess(cancelOrderModel: response));
    } else {
      emit(CancelOrderError(error: response.message.toString()));
    }
  }
}
