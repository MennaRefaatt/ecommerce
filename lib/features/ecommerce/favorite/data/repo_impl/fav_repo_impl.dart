import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/features/ecommerce/favorite/data/model/favourite_model.dart';

import '../../domain/repo_base/fav_repo_base.dart';

class FavRepoImpl implements DSFavouriteRemote {
final DSFavouriteRemote dsFavouriteRemote;
  FavRepoImpl({required this.dsFavouriteRemote});
  @override
  Future<FavouriteModel> getFavouriteData() async{
    final response = await dsFavouriteRemote.getFavouriteData();
    safePrint(response);
    if (response.status == true) {
      FavouriteModel favouriteModel = FavouriteModel.fromJson(response as Map<String, dynamic>);
      return favouriteModel as Future<FavouriteModel>;
    }else{
      return response;
    }
  }

  @override
  Future<FavouriteModel> toggleFavourite({required int productId}) async{
    final response = await dsFavouriteRemote.toggleFavourite(productId: productId);
    safePrint(response);
    if (response.status == true) {
      FavouriteModel favouriteModel = FavouriteModel.fromJson(response as Map<String, dynamic>);
      return favouriteModel as Future<FavouriteModel>;
    }else{
      return response;
    }
  }
}