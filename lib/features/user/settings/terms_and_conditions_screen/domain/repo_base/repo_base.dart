import '../../data/model/terms_and_conditions_model.dart';

abstract class TermsAndConditionsRepoBase {
  Future<TermsAndConditionsModel> getTermsAndConditions();
}