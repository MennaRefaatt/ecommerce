import '../../../../../core/helpers/safe_print.dart';
import '../../../../../core/services/network/api_constants.dart';
import '../../../../../core/services/network/api_exceptions.dart';
import '../../../../../core/services/network/api_service.dart';
import '../models/home_model.dart';

abstract class DSHomeRemote {
  Future<HomeModel> getHomeData();
}

class DSHomeRemoteImpl extends DSHomeRemote {
  DSHomeRemoteImpl();
  @override
  Future<HomeModel> getHomeData() async {
    try {
      final response = await ApiService.getData(
        endPoint: EndPoints.home,
      );
      safePrint(response);
      final homeModel = HomeModel.fromJson(response);
      return homeModel;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
