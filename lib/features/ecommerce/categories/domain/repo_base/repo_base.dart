import '../../data/model/categories_model.dart';

abstract class CategoriesRepoBase{
  Future<CategoriesModel> getCategoriesData();
}