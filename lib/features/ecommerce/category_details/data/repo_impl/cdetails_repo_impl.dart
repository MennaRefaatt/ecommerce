import 'package:ecommerce/features/ecommerce/category_details/data/data_source/ds_cDetails_remote.dart';
import 'package:ecommerce/features/ecommerce/category_details/domain/repo_base/repo_base.dart';
import '../model/category_details_model.dart';

class CDetailsReoImpl implements CDetailsRepoBase {
  final DsCDetailsRemote dsCDetailsRemote;

  CDetailsReoImpl({required this.dsCDetailsRemote});

  @override
  Future<CategoryDetailsModel> getCategoryDetails({required int categoryId}) async {
    try {
      final response = await dsCDetailsRemote.getCDetailsData(categoryId: categoryId);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}