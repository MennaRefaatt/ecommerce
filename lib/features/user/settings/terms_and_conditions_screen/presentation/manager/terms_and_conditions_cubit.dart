import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/user/settings/terms_and_conditions_screen/domain/repo_base/repo_base.dart';
import 'package:meta/meta.dart';

import '../../data/model/terms_and_conditions_model.dart';

part 'terms_and_conditions_state.dart';

class TermsAndConditionsCubit extends Cubit<TermsAndConditionsState> {
  TermsAndConditionsCubit(this.termsAndConditionsRepoBase)
      : super(TermsAndConditionsInitial());

  final TermsAndConditionsRepoBase termsAndConditionsRepoBase;

  Future<void> getTermsAndConditions() async {
    emit(TermsAndConditionsLoading());

    final response = await termsAndConditionsRepoBase.getTermsAndConditions();
    try {
      if (response.status == true) {
        emit(TermsAndConditionsSuccess(termsAndConditionsModel: response));
      } else {
        emit(TermsAndConditionsFailure(error: response.status.toString()));
      }
    } catch (e) {
      emit(TermsAndConditionsFailure(error: e.toString()));
    }
  }
}
