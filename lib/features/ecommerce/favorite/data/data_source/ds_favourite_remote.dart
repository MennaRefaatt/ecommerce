import 'package:ecommerce/core/services/network/api_service.dart';
import 'package:ecommerce/features/ecommerce/favorite/data/model/favourite_model.dart';

import '../../../../../core/helpers/safe_print.dart';
import '../../../../../core/services/network/api_constants.dart';
import '../../../../../core/services/network/api_exceptions.dart';

abstract class DSFavouriteRemote {
  Future<FavouriteModel> getFavouriteData();
  Future<FavouriteModel> toggleFavourite({required int productId});
}

class DSFavouriteRemoteImpl extends DSFavouriteRemote {
  DSFavouriteRemoteImpl();

  @override
  Future<FavouriteModel> getFavouriteData() {
    try {
      final response = ApiService.getData(endPoint: EndPoints.favorites);
      safePrint(response);
      final FavouriteModel favouriteModel = FavouriteModel.fromJson(response as Map<String, dynamic>);
      return favouriteModel as Future<FavouriteModel>;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<FavouriteModel> toggleFavourite({required int productId}) {
   try{
     final response = ApiService.postData(endPoint: EndPoints.favorites, data: {'product_id': productId});
     safePrint(response);
     final FavouriteModel favouriteModel = FavouriteModel.fromJson(response as Map<String, dynamic>);
     return favouriteModel as Future<FavouriteModel>;
   } on ServerException catch (e) {
     throw ServerException(message: e.message);
   }
  }
}
