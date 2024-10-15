import 'package:ecommerce/core/helpers/safe_print.dart';

import '../../domain/entity/register_request_entity.dart';
import '../../domain/repo_base/repo_base.dart';
import '../data_source/ds_register_local.dart';
import '../data_source/ds_register_remote.dart';
import '../models/register_model.dart';

class RegisterRepoImpl implements RegisterRepoBase {
  final DSRegisterRemote remoteDataSource;
  final DSRegisterLocal localDataSource;

  RegisterRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<RegisterResponse> register(
      RegisterRequestEntity registerRequestEntity) async {
    final response = await remoteDataSource.register(registerRequestEntity);
    if (response.status == true) {
      await localDataSource.cacheUserToken(response.data!.token!);
      await localDataSource.saveRegisterDataToLocal(
          registerData: response.data!);
      safePrint(response);
      return response;
    } else {
      return response;
    }
  }
}
