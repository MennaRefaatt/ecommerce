import 'package:ecommerce/features/home/domain/hom_entity/home_entity.dart';
import 'package:ecommerce/features/home/domain/repo_base/home_repo_base.dart';

import '../../data/models/home_model.dart';

class HomeUseCase {
  final HomeRepoBase homeRepoBase;
  HomeUseCase({required this.homeRepoBase});
  Future<HomeEntity> getHomeData()async {
    return homeRepoBase.getHomeData();
  }
}