import 'package:ecommerce/features/user/settings/profile_screen/data/model/update_account_model.dart';

import '../entities/update_acc_param.dart';

abstract class UpdateAccRepoBase {
  Future <UpdateAccountModel> updateAccount(UpdateAccParam updateAccParam);
}