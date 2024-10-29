import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/ecommerce/confirm_order/domain/repo_base/repo_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../../core/helpers/safe_print.dart';
import '../../data/model/confirm_order_model.dart';
import '../../domain/entity/confirm_param.dart';

part 'confirm_order_state.dart';

class ConfirmOrderCubit extends Cubit<ConfirmOrderState> {
  ConfirmOrderCubit(this.confirmRepoBase) : super(ConfirmOrderInitial());
  final ConfirmRepoBase confirmRepoBase;
  addConfirmOrderData(
      {required int addressId, required int paymentMethod}) async {
    safePrint("Calling addConfirmOrderData...");
    emit(ConfirmOrderLoading());
    try {
      final response = await confirmRepoBase.confirmOrder(ConfirmParam(
        addressId: addressId,
        paymentMethod: paymentMethod,
      ));
      if (response.status == true && response.data != null) {
        emit(ConfirmOrderSuccess(confirmOrderModel: response));
      } else {
        emit(ConfirmOrderError(error: response.message));
      }
    } catch (e) {
      emit(ConfirmOrderError(error: e.toString()));
    }
  }
}
