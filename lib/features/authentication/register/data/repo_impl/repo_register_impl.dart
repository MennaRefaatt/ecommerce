import '../../domain/entity/register_request_entity.dart';
import '../../domain/repo_base/repo_base.dart';
import '../data_source/ds_register_remote.dart';
import '../models/register_model.dart';

class RegisterRepoImpl implements RegisterRepoBase {
  final DSRegisterRemote remoteDataSource;

  RegisterRepoImpl({
    required this.remoteDataSource,
  });
  @override
  Future<RegisterSuccessResponse> register(
      RegisterRequestEntity registerRequestEntity) async {
    final response = await remoteDataSource.register(registerRequestEntity);
    if (response.status == true) {
      return response;
    } else {
      return response;
    }
  }
}
