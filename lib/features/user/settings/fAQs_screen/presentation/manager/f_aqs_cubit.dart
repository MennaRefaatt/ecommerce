import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/user/settings/fAQs_screen/domain/repo_base/repo_base.dart';
import 'package:meta/meta.dart';

import '../../data/model/f_a_q_s_model.dart';

part 'f_aqs_state.dart';

class FAqsCubit extends Cubit<FAqsState> {
  FAqsCubit(this.faqsRepoBase) : super(FAqsInitial());
final FAQsRepoBase  faqsRepoBase;
  Future<void> getFAQsData() async {
    emit(FAqsLoading());
    final response = await faqsRepoBase.getFAQsData();
    try {
      if (response.status == true) {
        emit(FAqsSuccess(fAQsModel:  response));
      } else {
        emit(FAqsFailure(error: response.toString()));
      }
    } catch (e) {
      emit(FAqsFailure(error: e.toString()));
    }
  }

}
