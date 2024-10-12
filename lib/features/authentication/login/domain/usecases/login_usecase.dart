
import 'package:ecommerce/features/authentication/login/data/models/login_success_response.dart';
import '../entities/login_request_entity.dart';
import '../repo_base/login_repo_base.dart';
class LoginUseCase {
  final LoginRepoBase loginRepo;
  LoginUseCase({required this.loginRepo});

  Future<LoginSuccessResponse> execute(LoginRequestEntity loginRequestEntity) async{
    return loginRepo.login(loginRequestEntity);
  }
}
