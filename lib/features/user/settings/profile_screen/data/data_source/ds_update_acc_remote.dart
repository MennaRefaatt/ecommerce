import 'package:ecommerce/features/user/settings/profile_screen/data/model/update_account_model.dart';
import 'package:ecommerce/features/user/settings/profile_screen/domain/entities/update_acc_param.dart';

import '../../../../../../core/services/network/api_constants.dart';
import '../../../../../../core/services/network/api_service.dart';

abstract class DsUpdateAccRemote {
  Future<UpdateAccountModel> updateAccount(UpdateAccParam updateAccParam);
}
class DsUpdateAccRemoteImpl implements DsUpdateAccRemote{
  @override
  Future<UpdateAccountModel> updateAccount(UpdateAccParam updateAccParam) async{
    try {
      final response =await ApiService.putData(
        endPoint: EndPoints.updateProfile,
        data: updateAccParam.toJson(),
      );
      UpdateAccountModel model = UpdateAccountModel.fromJson(response);
      return model;
    } catch (e) {
      rethrow;
    }
  }
}