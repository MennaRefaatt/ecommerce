import 'package:bloc/bloc.dart';
import 'package:ecommerce/core/forms/user_data_form_validators.dart';
import 'package:ecommerce/features/authentication/login/domain/usecases/login_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/login_request_entity.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(LoginInitial());
  final LoginUseCase _loginUseCase;
  UserDataFormValidators userDataFormValidators = UserDataFormValidators();
  login() async {
    emit(LoginLoading());
    final response = await _loginUseCase.execute(LoginRequestEntity(
      email: userDataFormValidators.emailController.text,
      password: userDataFormValidators.passwordController.text,
    ));
    if (response.status == true) {
      emit(LoginSuccess(response.message.toString()));
    } else {
      emit(LoginError(response.toString()));
    }
  }
}
