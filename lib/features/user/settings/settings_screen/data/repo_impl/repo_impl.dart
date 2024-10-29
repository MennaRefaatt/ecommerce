import '../../domain/repo_base/repo_base.dart';
import '../data_source/ds_logout_remote.dart';
import '../model/log_out_model.dart';

class LogoutRepoImpl extends LogoutRepoBase {
  final DSLogoutRemote _dsLogoutRemote ;

  LogoutRepoImpl(this._dsLogoutRemote);

  @override
  Future<LogOutModel> logOut() async {
    final response = await _dsLogoutRemote.logOut();
    try {
      return response;
    } catch (e) {
      rethrow;
    }
  }
}