import 'package:ecommerce/features/user/settings/profile_screen/data/data_source/ds_update_acc_remote.dart';
import 'package:ecommerce/features/user/settings/profile_screen/domain/entities/update_acc_param.dart';

import '../../domain/repo_base/update_acc_repo_base.dart';
import '../model/update_account_model.dart';
class UpdateAccRepoImpl implements UpdateAccRepoBase{
  final DsUpdateAccRemote dsUpdateAccRemote;
  UpdateAccRepoImpl(this.dsUpdateAccRemote);
  @override
  Future <UpdateAccountModel> updateAccount(UpdateAccParam updateAccParam) async{
    try {
      final response =await dsUpdateAccRemote.updateAccount(updateAccParam);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}