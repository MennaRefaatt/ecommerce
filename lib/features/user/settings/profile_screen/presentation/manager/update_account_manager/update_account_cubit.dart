import 'package:bloc/bloc.dart';
import 'package:ecommerce/core/helpers/shared_pref.dart';
import 'package:ecommerce/features/user/settings/profile_screen/domain/repo_base/update_acc_repo_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../../../../core/helpers/shared_pref_keys.dart';
import '../../../domain/entities/update_acc_param.dart';
part 'update_account_state.dart';

class UpdateAccountCubit extends Cubit<UpdateAccountState> {
  UpdateAccountCubit(this.updateAccRepoBase) : super(UpdateAccountInitial());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
final UpdateAccRepoBase updateAccRepoBase ;
  void init() {
    nameController.text = SharedPref.getString(key: MySharedKeys.userName)!;
    phoneController.text = SharedPref.getString(key: MySharedKeys.phone)!;
    emailController.text = SharedPref.getString(key: MySharedKeys.email)!;
  }

  updateAccount() async {
    emit(UpdateAccountLoading());
   final result = await updateAccRepoBase.updateAccount(
        UpdateAccParam(
            name: nameController.text,
            phone: phoneController.text,
            email: SharedPref.getString(key: MySharedKeys.email)!));
try {
  if (result.status == true) {
    SharedPref.putString(key: MySharedKeys.userName, value: nameController.text);
    SharedPref.putString(key: MySharedKeys.phone, value: phoneController.text);
    SharedPref.putString(key: MySharedKeys.email, value: emailController.text);
    emit(UpdateAccountSuccess(
       result.message,
    ));
  } else {
    emit(UpdateAccountError( result.message));
  }
} catch (e) {
  emit(UpdateAccountError(e.toString()));
}
  }
}
