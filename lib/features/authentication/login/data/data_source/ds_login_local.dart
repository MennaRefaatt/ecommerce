
import 'package:ecommerce/features/authentication/login/data/models/login_success_response.dart';

import '../../../../../core/helpers/secure_storage/secure_keys.dart';
import '../../../../../core/helpers/secure_storage/secure_storage.dart';
import '../../../../../core/helpers/shared_pref.dart';
import '../../../../../core/helpers/shared_pref_keys.dart';

abstract class DSLoginLocal {
  Future<void> cacheUserToken(String token);

  Future<void> saveDataToLocal({required LoginData loginData});

  Future<LoginSuccessResponse> getCachedUser();

  Future<void> clear();
}

class DSLoginLocalImpl implements DSLoginLocal {
  DSLoginLocalImpl();

  @override
  Future<void> cacheUserToken(String token) async {
    await SecureStorageService.writeData(SecureKeys.token,token);
  }

  @override
  Future<void> clear() async {
    SharedPref.clear();
    SecureStorageService.deleteData(SecureKeys.token);

  }

  @override
  Future<LoginSuccessResponse> getCachedUser() async {
   SharedPref.getString(key: MySharedKeys.phone);
   SharedPref.getString(key: MySharedKeys.userName);
   SharedPref.getString(key: MySharedKeys.email);
   SharedPref.getString(key: MySharedKeys.gender);
   SecureStorageService.readData(SecureKeys.token);

    return LoginSuccessResponse.fromJson({});
  }
  @override
  Future<void> saveDataToLocal({required LoginData loginData}) async {
    SharedPref.putString(key: MySharedKeys.email, value: loginData.email);
    SharedPref.putString(key: MySharedKeys.userId, value: loginData.userId.toString());
    SharedPref.putString(key: MySharedKeys.userName, value: loginData.name);
    SharedPref.putString(key: MySharedKeys.phone, value: loginData.phone);
    await SecureStorageService.writeData(SecureKeys.token, loginData.token!);

  }
}
