import 'package:ecommerce/core/helpers/safe_print.dart';

import '../../../../../core/services/network/api_constants.dart';
import '../../../../../core/services/network/api_exceptions.dart';
import '../../../../../core/services/network/api_service.dart';
import '../../domain/entity/register_request_entity.dart';
import '../models/register_model.dart';

abstract class DSRegisterRemote {
  Future<RegisterResponse> register(RegisterRequestEntity registerRequestEntity);
}
class DSRegisterRemoteImpl implements DSRegisterRemote {
  DSRegisterRemoteImpl();
  @override
  Future<RegisterResponse> register(RegisterRequestEntity registerRequestEntity) async {
    try {
      final response = await ApiService.postData(
        endPoint: EndPoints.register,
        data: registerRequestEntity.toJson(),
      );
      safePrint(response);

      final registerResponseModel = RegisterResponse.fromJson(response);
      return registerResponseModel;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}