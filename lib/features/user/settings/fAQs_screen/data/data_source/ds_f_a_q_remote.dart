import '../../../../../../core/services/network/api_constants.dart';
import '../../../../../../core/services/network/api_service.dart';
import '../model/f_a_q_s_model.dart';

abstract class DSFAQRemote {
  Future<FAQsModel> getFAQsData();
}

class DSFAQRemoteImpl extends DSFAQRemote {
  @override
  Future<FAQsModel> getFAQsData() async {
    final response = await ApiService.getData(endPoint: EndPoints.fAQs);
    try {
      FAQsModel fAQSModel = FAQsModel.fromJson(response);
      return fAQSModel;
    } catch (e) {
      rethrow;
    }
  }
}