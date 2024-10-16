
import '../../../../../../core/helpers/safe_print.dart';
import '../../../../../../core/services/network/api_constants.dart';
import '../../../../../../core/services/network/api_exceptions.dart';
import '../../../../../../core/services/network/api_service.dart';
import '../../domain/entity/complaints_param.dart';
import '../model/complaints_model.dart';

abstract class DSComplaintsRemote {
  Future<ComplaintsModel> sendComplaints(ComplaintsParam complaintsParam);
}

class DSComplaintsRemoteImpl implements DSComplaintsRemote {
  DSComplaintsRemoteImpl();

  @override
  Future<ComplaintsModel> sendComplaints(
      ComplaintsParam complaintsParam) async {
    try {
      final response = await ApiService.postData(
        endPoint: EndPoints.complaints,
        data: complaintsParam.toJson(),
      );
      safePrint(response);
      final complaintsModel = ComplaintsModel.fromJson(response);
      return complaintsModel;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
