import '../../../../../core/helpers/secure_storage/secure_keys.dart';
import '../../../../../core/helpers/secure_storage/secure_storage.dart';
import '../../../../../core/helpers/shared_pref.dart';
import '../../../../../core/helpers/shared_pref_keys.dart';
import '../models/register_model.dart';

abstract class DSRegisterLocal {
  Future<void> cacheUserToken(String token);
  Future<void> saveRegisterDataToLocal({required RegisterData registerData});
  Future<RegisterResponse> getCachedUser();
  Future<void> clear();
}

class DSRegisterLocalImpl implements DSRegisterLocal {
  @override
  Future<void> cacheUserToken(String token) async {
    await SecureStorageService.writeData(SecureKeys.token, token);
  }

  @override
  Future<void> clear() async {
    SharedPref.clear();
    SecureStorageService.deleteData(SecureKeys.token);
  }

  @override
  Future<RegisterResponse> getCachedUser() async {
    final name = SharedPref.getString(key: MySharedKeys.userName);
    final email = SharedPref.getString(key: MySharedKeys.email);
    final phone = SharedPref.getString(key: MySharedKeys.phone);
    final token = await SecureStorageService.readData(SecureKeys.token);

    // Assuming you build RegisterSuccessResponse from cached data
    return RegisterResponse.fromJson({
      'name': name,
      'email': email,
      'phone': phone,
      'token': token,
    });
  }

  @override
  Future<void> saveRegisterDataToLocal(
      {required RegisterData registerData}) async {
    SharedPref.putString(key: MySharedKeys.userName, value: registerData.name!);
    SharedPref.putString(key: MySharedKeys.email, value: registerData.email!);
    SharedPref.putString(key: MySharedKeys.phone, value: registerData.phone!);
    await SecureStorageService.writeData(SecureKeys.token, registerData.token!);
  }
}
