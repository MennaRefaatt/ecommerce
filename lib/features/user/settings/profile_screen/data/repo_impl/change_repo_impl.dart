import 'package:ecommerce/features/user/settings/profile_screen/data/data_source/ds_change_pass_remote.dart';

import '../../domain/entities/change_pass_param.dart';
import '../../domain/repo_base/change_repo_base.dart';

class ChangeRepoImpl implements ChangeRepoBase {
  final DSChangePassRemote dsChangePassRemote;

  ChangeRepoImpl({required this.dsChangePassRemote});

  @override
  Future <bool> changePassword(ChangePassParam changePassParam) async {
    final response = await dsChangePassRemote.changePassword(changePassParam);
    try {
      return response;
    } catch (e) {
      rethrow;
    }
  }
}