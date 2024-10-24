import 'package:dio/dio.dart';
import 'package:ecommerce/features/authentication/login/data/data_source/ds_login_local.dart';
import 'package:ecommerce/features/authentication/login/data/data_source/ds_login_remote.dart';
import 'package:ecommerce/features/authentication/login/data/repos_impl/login_repo.dart';
import 'package:ecommerce/features/authentication/login/domain/repo_base/login_repo_base.dart';
import 'package:ecommerce/features/authentication/login/domain/usecases/login_usecase.dart';
import 'package:ecommerce/features/authentication/register/data/data_source/ds_register_local.dart';
import 'package:ecommerce/features/authentication/register/data/data_source/ds_register_remote.dart';
import 'package:ecommerce/features/authentication/register/data/repo_impl/repo_register_impl.dart';
import 'package:ecommerce/features/authentication/register/domain/repo_base/repo_base.dart';
import 'package:ecommerce/features/authentication/register/domain/usecases/register_usecase.dart';
import 'package:get_it/get_it.dart';
import '../../features/ecommerce/home/data/data_source/ds_home_remote.dart';
import '../../features/ecommerce/home/data/repo_impl/home_repo_impl.dart';
import '../../features/ecommerce/home/domain/repo_base/home_repo_base.dart';
import '../../features/ecommerce/home/domain/usecases/home_usecase.dart';
import '../../features/ecommerce/maps/data/data_source/data_source.dart';
import '../../features/ecommerce/maps/data/repo_impl/repo_impl.dart';
import '../../features/ecommerce/maps/domain/repo_base/repo_base.dart';
import '../../features/ecommerce/maps/domain/use_case/location_use_case.dart';
import '../../features/ecommerce/maps/presentation/manager/location_cubit.dart';
import '../../features/ecommerce/search/data/data_source/ds_search_remote.dart';
import '../../features/ecommerce/search/data/repo_impl/search_repo_impl.dart';
import '../../features/ecommerce/search/domain/repo_base/search_repo_base.dart';
import '../../features/ecommerce/search/domain/usecase/search_usecase.dart';
import '../services/network/api_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Register Dio
  sl.registerLazySingleton(() => Dio());

  // Register ApiService
  sl.registerLazySingleton(() => ApiService());

  //login
  sl.registerLazySingleton<DSLoginRemote>(() => DSLoginRemoteImpl());
  sl.registerLazySingleton<DSLoginLocal>(() => DSLoginLocalImpl());
  sl.registerLazySingleton<LoginRepoBase>(
      () => LoginRepoImpl(remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton(() => LoginUseCase(loginRepo: sl<LoginRepoBase>()));

  // Register
  sl.registerLazySingleton(
      () => RegisterUseCase(registerRepo: sl<RegisterRepoBase>()));
  sl.registerLazySingleton<DSRegisterRemote>(() => DSRegisterRemoteImpl());
  sl.registerLazySingleton<RegisterRepoBase>(
    () => RegisterRepoImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  sl.registerLazySingleton<DSRegisterLocal>(() => DSRegisterLocalImpl());


  // Home
  sl.registerLazySingleton<HomeRepoBase>(
      () => HomeRepoImpl(dsHomeRemote: sl()));
  sl.registerLazySingleton(() => HomeUseCase(homeRepoBase: sl<HomeRepoBase>()));
  sl.registerLazySingleton<DSHomeRemote>(() => DSHomeRemoteImpl());

  //search
  sl.registerLazySingleton(
      () => SearchUseCase(searchRepoBase: sl<SearchRepoBase>()));
  sl.registerLazySingleton<SearchRepoBase>(
      () => SearchRepoImpl(dsSearchRemote: sl()));
  sl.registerLazySingleton<DSSearchRemote>(() => DSSearchRemoteImpl());

  //maps
  sl.registerLazySingleton(
          () => GetUserLocationUseCase(sl<LocationRepository>()));
  sl.registerLazySingleton<LocationRepository>(
          () => LocationRepositoryImpl( sl()));
  sl.registerLazySingleton<GeolocationDataSource>(() => GeolocationDataSourceImpl());

}
