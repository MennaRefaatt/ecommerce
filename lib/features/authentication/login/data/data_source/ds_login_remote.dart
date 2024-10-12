import 'package:ecommerce/core/helpers/safe_print.dart';

import '../../../../../core/services/network/api_constants.dart';
import '../../../../../core/services/network/api_exceptions.dart';
import '../../../../../core/services/network/api_service.dart';
import '../../domain/entities/login_request_entity.dart';
import '../models/login_success_response.dart';

abstract class DSLoginRemote {
  Future<LoginSuccessResponse> login(LoginRequestEntity loginRequestEntity);
}


class DSLoginRemoteImpl implements DSLoginRemote {
  DSLoginRemoteImpl();

  @override
  Future<LoginSuccessResponse> login(LoginRequestEntity loginRequestEntity) async {
    try {
      final response = await ApiService.postData(
        endPoint: EndPoints.login,
        data: loginRequestEntity.toJson(),
      );
      safePrint(response);
        final loginResponseModel = LoginSuccessResponse.fromJson(response);
        return loginResponseModel;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}