import '../../data/model/log_out_model.dart';

abstract class LogoutRepoBase {
  Future<LogOutModel> logOut();
}