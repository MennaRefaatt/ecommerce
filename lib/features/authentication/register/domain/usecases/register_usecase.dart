import '../../data/models/register_model.dart';
import '../entity/register_request_entity.dart';
import '../repo_base/repo_base.dart';

class RegisterUseCase {
  final RegisterRepoBase registerRepo;
  RegisterUseCase({required this.registerRepo});

  Future<RegisterSuccessResponse> execute(RegisterRequestEntity registerRequestEntity) async{
    return registerRepo.register(registerRequestEntity);
  }
}