import 'package:ecommerce/features/ecommerce/favorite/data/model/favourite_model.dart';

abstract class DSFavouriteRemote {
  Future<FavouriteModel> getFavouriteData();
  Future<FavouriteModel> toggleFavourite({required int productId});
}