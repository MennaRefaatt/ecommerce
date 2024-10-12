import 'package:ecommerce/features/home/data/models/home_model.dart';
import 'package:ecommerce/features/home/domain/hom_entity/home_entity.dart';

abstract class HomeRepoBase {
  Future<HomeEntity> getHomeData();
}