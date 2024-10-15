import 'package:ecommerce/core/helpers/safe_print.dart';
import '../../domain/home_entity/home_entity.dart';
import '../../domain/repo_base/home_repo_base.dart';
import '../data_source/ds_home_remote.dart';
import '../mapper/home_mapper.dart';

class HomeRepoImpl implements HomeRepoBase {
  final DSHomeRemote dsHomeRemote;
  HomeRepoImpl({
    required this.dsHomeRemote,
  });
  @override
  Future<HomeEntity> getHomeData() async {
    final response = await dsHomeRemote.getHomeData();
    safePrint(response);
    if (response.status == true) {
      HomeEntity homeEntity = HomeMapper.mapToEntity(response);
      return homeEntity;
    } else {
      return HomeEntity(status: false, data: HomeDataEntity(products: [], banners: []));
    }
  }
}
