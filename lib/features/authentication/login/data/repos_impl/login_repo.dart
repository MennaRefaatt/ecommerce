
import '../../domain/repo_base/login_repo_base.dart';
import '../data_source/ds_login_local.dart';
import '../data_source/ds_login_remote.dart';
import '../../domain/entities/login_request_entity.dart';
import '../models/login_success_response.dart';


class LoginRepoImpl implements LoginRepoBase {
  final DSLoginRemote remoteDataSource;
   final DSLoginLocal localDataSource;

  LoginRepoImpl({
    required this. remoteDataSource,
     required this. localDataSource,
  });

  @override
  Future<LoginSuccessResponse> login(LoginRequestEntity loginRequestEntity) async {
    final response = await remoteDataSource.login(loginRequestEntity);
    if (response.status == true) {
       await localDataSource.cacheUserToken(response.data!.token!);
      return response;
    } else {
      return response;
    }
  }
}
