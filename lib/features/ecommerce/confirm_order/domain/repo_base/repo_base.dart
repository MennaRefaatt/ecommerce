import '../../data/model/confirm_order_model.dart';
import '../entity/confirm_param.dart';

abstract class ConfirmRepoBase {
  Future<ConfirmOrderModel> confirmOrder(ConfirmParam confirmParam);
}