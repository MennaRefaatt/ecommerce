import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/user/settings/profile_screen/domain/repo_base/change_repo_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/change_pass_param.dart';
part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.changeRepoBase) : super(ChangePasswordInitial());
  bool obscureText1 = true;
  bool obscureText2 = true;
  bool obscureText3 = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final ChangeRepoBase changeRepoBase;
  changePassword() async {
    emit(ChangePasswordLoading());
    final result = await changeRepoBase.changePassword(ChangePassParam(
        currentPassword: currentPassController.text,
        newPassword: newPassController.text,
        confirmPassword: confirmPasswordController.text));
    try {
      if (result == true) {
        emit(ChangePasswordSuccess(message: result.toString()));
      } else {
        emit(ChangePasswordError(result.toString()));
      }
    } catch (e) {
      emit(ChangePasswordError(e.toString()));
    }
  }
}
