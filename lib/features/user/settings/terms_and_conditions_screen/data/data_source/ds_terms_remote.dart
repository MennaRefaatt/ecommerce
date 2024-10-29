import 'package:ecommerce/features/user/settings/terms_and_conditions_screen/data/model/terms_and_conditions_model.dart';

import '../../../../../../core/services/network/api_constants.dart';
import '../../../../../../core/services/network/api_service.dart';

abstract class DsTermsRemote {
  Future<TermsAndConditionsModel> getTermsAndConditions();
}

class DsTermsRemoteImpl implements DsTermsRemote {
  @override
  Future<TermsAndConditionsModel> getTermsAndConditions() async {
    final response = await ApiService.getData(endPoint: EndPoints.settings);
    try {
      TermsAndConditionsModel termsAndConditionsModel =
          TermsAndConditionsModel.fromJson(response);
      return termsAndConditionsModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
