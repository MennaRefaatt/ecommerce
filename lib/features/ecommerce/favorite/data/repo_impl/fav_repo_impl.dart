import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/features/ecommerce/favorite/data/model/favourite_model.dart';
import '../../domain/repo_base/fav_repo_base.dart';
import '../data_source/ds_favourite_remote.dart';

class FavRepoImpl implements FavRepoBase {
final DSFavouriteRemote dsFavouriteRemote;
  FavRepoImpl({required this.dsFavouriteRemote});
  @override
  Future<FavouriteModel> getFavouriteData() async {
    final response = await dsFavouriteRemote.getFavouriteData();
    safePrint(response);
    if (response.status == true) {
      return response;
    }else{
      return response;
    }
  }

  @override
  Future<FavouriteModel> toggleFavourite({required int productId}) async{
    final response = await dsFavouriteRemote.toggleFavourite(productId: productId);
    safePrint(response);
    if (response.status == true) {
      return response;
    }else{
      return response;
    }
  }
}