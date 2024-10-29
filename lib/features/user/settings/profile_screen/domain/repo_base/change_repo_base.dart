import 'package:ecommerce/features/user/settings/profile_screen/domain/entities/change_pass_param.dart';

abstract class ChangeRepoBase {
  Future <bool> changePassword(ChangePassParam changePassParam);
}