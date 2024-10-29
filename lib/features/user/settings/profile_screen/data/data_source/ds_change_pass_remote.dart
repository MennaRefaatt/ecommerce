import '../../../../../../core/services/network/api_constants.dart';
import '../../../../../../core/services/network/api_service.dart';
import '../../domain/entities/change_pass_param.dart';

abstract class DSChangePassRemote {
  Future<bool> changePassword(ChangePassParam changePassParam);
}
class DSChangePassRemoteImpl implements DSChangePassRemote{
  @override
  Future<bool> changePassword(ChangePassParam changePassParam) async{
    try {
      final response =await ApiService.postData(
        endPoint: EndPoints.changePassword,
        data: changePassParam.toJson(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}