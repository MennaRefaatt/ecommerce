import '../../data/model/category_details_model.dart';

abstract class CDetailsRepoBase{
  Future<CategoryDetailsModel> getCategoryDetails({required int categoryId});
}