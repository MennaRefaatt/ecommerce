import '../../../../../../core/services/network/api_constants.dart';
import '../../../../../../core/services/network/api_service.dart';
import '../model/log_out_model.dart';

abstract class DSLogoutRemote {
  Future<LogOutModel> logOut();
}
class DSLogoutRemoteImpl extends DSLogoutRemote {
  @override
  Future<LogOutModel> logOut() async {
    final response = await ApiService.postData(endPoint: EndPoints.logout);
    try {
      LogOutModel logOutModel = LogOutModel.fromJson(response);
      return logOutModel;
    } catch (e) {
      rethrow;
    }
  }
}