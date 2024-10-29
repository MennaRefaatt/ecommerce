import 'package:ecommerce/core/services/network/api_service.dart';
import 'package:ecommerce/features/ecommerce/confirm_order/data/model/confirm_order_model.dart';
import 'package:ecommerce/features/ecommerce/confirm_order/domain/entity/confirm_param.dart';

import '../../../../../core/helpers/safe_print.dart';
import '../../../../../core/services/network/api_constants.dart';

abstract class DsConfirmRemote {
  Future<ConfirmOrderModel> confirmOrder(ConfirmParam confirmParam);
}

class DsConfirmRemoteImpl implements DsConfirmRemote {
  DsConfirmRemoteImpl();

  @override
  Future<ConfirmOrderModel> confirmOrder(ConfirmParam confirmParam) async {
    final response =
        await ApiService.postData(endPoint: EndPoints.addOrders, data:
     confirmParam.toJson()
    );
    try {
      ConfirmOrderModel confirmOrderModel =
          ConfirmOrderModel.fromJson(response);
      safePrint(confirmOrderModel);
      return confirmOrderModel;
    } catch (e) {
      rethrow;
    }
  }
}
