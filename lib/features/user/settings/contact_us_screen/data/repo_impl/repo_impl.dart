import '../../domain/repo_base/repo_base.dart';
import '../data_source/ds_contact_us_remote.dart';
import '../model/contact_us_model.dart';

class ContactUsRepoImpl implements ContactUsRepoBase {
  final DSContactUsRemote remoteDataSource;
  ContactUsRepoImpl({required this.remoteDataSource});
  @override
  Future<ContactUsModel> getContactUs() async {
    final response = await remoteDataSource.getContactUs();

    try {
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}
