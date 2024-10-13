import '../home_entity/home_entity.dart';

abstract class HomeRepoBase {
  Future<HomeEntity> getHomeData();
}