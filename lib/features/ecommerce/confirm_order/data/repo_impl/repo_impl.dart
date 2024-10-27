import '../../domain/entity/confirm_param.dart';
import '../../domain/repo_base/repo_base.dart';
import '../data_source/ds_confirm_remote.dart';
import '../model/confirm_order_model.dart';

class ConfirmRepoImpl implements ConfirmRepoBase {
  final DsConfirmRemote dsConfirmRemote;
  ConfirmRepoImpl(this.dsConfirmRemote);
  @override
  Future<ConfirmOrderModel> confirmOrder(ConfirmParam confirmParam) async {
    final response = await dsConfirmRemote.confirmOrder(confirmParam);
    try {
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
