import '../../../../../core/services/network/api_constants.dart';
import '../../../../../core/services/network/api_exceptions.dart';
import '../../../../../core/services/network/api_service.dart';
import '../../domain/entity/register_request_entity.dart';
import '../models/register_model.dart';

abstract class DSRegisterRemote {
  Future<RegisterSuccessResponse> register(RegisterRequestEntity registerRequestEntity);
}
class DSRegisterRemoteImpl implements DSRegisterRemote {
  DSRegisterRemoteImpl();
  @override
  Future<RegisterSuccessResponse> register(RegisterRequestEntity registerRequestEntity) async {
    try {
      final response = await ApiService.postData(
        endPoint: EndPoints.register,
        data: registerRequestEntity.toJson(),
      );
      final registerResponseModel = RegisterSuccessResponse.fromJson(response);
      return registerResponseModel;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}