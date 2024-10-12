import 'package:ecommerce/features/authentication/login/data/models/login_success_response.dart';

import '../entities/login_request_entity.dart';

abstract class LoginRepoBase {
  Future<LoginSuccessResponse> login(LoginRequestEntity loginRequestEntity);
}