import '../home_entity/home_entity.dart';
import '../repo_base/home_repo_base.dart';

class HomeUseCase {
  final HomeRepoBase homeRepoBase;
  HomeUseCase({required this.homeRepoBase});
  Future<HomeEntity> getHomeData()async {
    return homeRepoBase.getHomeData();
  }
}