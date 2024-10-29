import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/user/settings/settings_screen/domain/repo_base/repo_base.dart';
import 'package:meta/meta.dart';

import '../../data/model/log_out_model.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.logoutRepoBase) : super(SettingsInitial());
  final LogoutRepoBase logoutRepoBase;
  void logOut() async {
    emit(LogOutLoading());
    final response = await logoutRepoBase.logOut();
    try {
      if (response.status == true) {
        emit(LogOutSuccess(logOutModel: response));
      } else {
        emit(LogOutError(response.message));
      }
    } catch (e) {
      emit(LogOutError(e.toString()));
    }
  }
}
