import '../../domain/repo_base/repo_base.dart';
import '../data_source/ds_terms_remote.dart';
import '../model/terms_and_conditions_model.dart';

class TermsAndConditionsRepoImpl implements TermsAndConditionsRepoBase {
  final DsTermsRemote _dsTermsRemote;

  TermsAndConditionsRepoImpl(this._dsTermsRemote);

  @override
  Future<TermsAndConditionsModel> getTermsAndConditions() async {
    final response = await _dsTermsRemote.getTermsAndConditions();
    try {
      return response;
    } catch (e) {
      rethrow;
    }
  }
}