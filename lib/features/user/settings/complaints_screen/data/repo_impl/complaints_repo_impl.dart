import 'package:ecommerce/features/user/settings/complaints_screen/data/data_source/ds_complaints_remote.dart';
import '../../../../../../core/helpers/safe_print.dart';
import '../../domain/entity/complaints_param.dart';
import '../model/complaints_model.dart';

abstract class ComplaintsRepoBase {
  Future<ComplaintsModel> sendComplaints(ComplaintsParam complaintsParam);
}

class ComplaintsRepoImpl implements ComplaintsRepoBase {
  final DSComplaintsRemote remoteDataSource;

  ComplaintsRepoImpl({required this.remoteDataSource});
  @override
  Future<ComplaintsModel> sendComplaints(
      ComplaintsParam complaintsParam) async {
    final response = await remoteDataSource.sendComplaints(complaintsParam);
    safePrint(response.toString());
    if (response.status == true) {
      return response;
    } else {
      return response;
    }
  }
}
