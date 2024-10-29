import '../../data/model/f_a_q_s_model.dart';

abstract class FAQsRepoBase {
  Future<FAQsModel> getFAQsData();
}