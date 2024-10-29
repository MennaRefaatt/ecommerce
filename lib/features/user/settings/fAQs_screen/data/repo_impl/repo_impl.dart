import '../../domain/repo_base/repo_base.dart';
import '../data_source/ds_f_a_q_remote.dart';
import '../model/f_a_q_s_model.dart';

class FAQsRepoImpl extends FAQsRepoBase {
  final DSFAQRemote dsFAQRemote;
  FAQsRepoImpl({required this.dsFAQRemote});

  @override
  Future<FAQsModel> getFAQsData() async {
    final response = await dsFAQRemote.getFAQsData();
    try {
      return response;
    } catch (e) {
      rethrow;
    }
  }
}