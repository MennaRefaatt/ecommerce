import 'package:dio/dio.dart';
import 'package:ecommerce/features/authentication/login/data/data_source/ds_login_local.dart';
import 'package:ecommerce/features/authentication/login/data/data_source/ds_login_remote.dart';
import 'package:ecommerce/features/authentication/login/data/repos_impl/login_repo.dart';
import 'package:ecommerce/features/authentication/login/domain/repo_base/login_repo_base.dart';
import 'package:ecommerce/features/authentication/login/domain/usecases/login_usecase.dart';
import 'package:ecommerce/features/authentication/register/data/data_source/ds_register_remote.dart';
import 'package:ecommerce/features/authentication/register/data/repo_impl/repo_register_impl.dart';
import 'package:ecommerce/features/authentication/register/domain/repo_base/repo_base.dart';
import 'package:ecommerce/features/authentication/register/domain/usecases/register_usecase.dart';
import 'package:ecommerce/features/home/data/data_source/ds_home_remote.dart';
import 'package:get_it/get_it.dart';
import '../../features/home/data/repo_impl/home_repo_impl.dart';
import '../../features/home/domain/repo_base/home_repo_base.dart';
import '../../features/home/domain/usecases/home_usecase.dart';
import '../services/network/api_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Register Dio
  sl.registerLazySingleton(() => Dio());

  // Register ApiService
  sl.registerLazySingleton(() => ApiService());

  //login
  sl.registerLazySingleton<DSLoginRemote>(
        () => DSLoginRemoteImpl(),
  );

  sl.registerLazySingleton<DSLoginLocal>(
        () => DSLoginLocalImpl(),
  );

  sl.registerLazySingleton<LoginRepoBase>(
        () => LoginRepoImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(() => LoginUseCase(loginRepo: sl<LoginRepoBase>()));


  // Register
  sl.registerLazySingleton(() => RegisterUseCase(registerRepo: sl<RegisterRepoBase>()));
  sl.registerLazySingleton<DSRegisterRemote>(
        () => DSRegisterRemoteImpl(),
  );

  sl.registerLazySingleton<RegisterRepoBase>(
        () => RegisterRepoImpl(
      remoteDataSource: sl(),
    ),
  );

  // Home
  sl.registerLazySingleton<HomeRepoBase>(
        () => HomeRepoImpl(
      dsHomeRemote: sl(),
    ),
  );
  sl.registerLazySingleton(() => HomeUseCase(homeRepoBase: sl<HomeRepoBase>()));
sl.registerLazySingleton<DSHomeRemote>(
        () => DSHomeRemoteImpl(),
);
}
