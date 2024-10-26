import 'package:ecommerce/core/helpers/safe_print.dart';

import '../../domain/repo_base/repo_base.dart';
import '../data_source/ds_categories_remote.dart';
import '../model/categories_model.dart';

class CategoriesRepoImpl extends CategoriesRepoBase {
  final DsCategoriesRemote _dsCategoriesRemote;
  CategoriesRepoImpl(this._dsCategoriesRemote);
  @override
  Future<CategoriesModel> getCategoriesData() async {
    try {
      final response = await _dsCategoriesRemote.getCategoriesData();
      safePrint(response);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}
