import '../../../../../../core/helpers/safe_print.dart';
import '../../../../../../core/services/network/api_constants.dart';
import '../../../../../../core/services/network/api_service.dart';
import '../model/contact_us_model.dart';

abstract class DSContactUsRemote {
  Future<ContactUsModel> getContactUs();
}
class DSContactUsRemoteImpl implements DSContactUsRemote{
  @override
  Future<ContactUsModel> getContactUs() async {
    final response = await ApiService.getData(endPoint: EndPoints.contactUs);
    safePrint(response.toString());
    try {
      final contactUsModel = ContactUsModel.fromJson(response);
      return contactUsModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}