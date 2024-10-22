import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/ecommerce/favorite/data/repo_impl/fav_repo_impl.dart';
import 'package:meta/meta.dart';
import '../../data/model/favourite_model.dart';
part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit(this.favRepoImpl) : super(FavouriteInitial());
final FavRepoImpl favRepoImpl;
  getFavouriteData() {
    emit(FavouriteLoading());
    favRepoImpl.getFavouriteData().then((value) {
      emit(FavouriteSuccess(favouriteModel: value));
    }).catchError((error) {
      emit(FavouriteError(error: error.toString()));
    });
  }

  Future toggleFavourite({required int productId}) async{
    emit(FavouriteLoading());
    favRepoImpl.toggleFavourite(productId: productId).then((value) {
      emit(FavouriteSuccess(favouriteModel: value));
    }).catchError((error) {
      emit(FavouriteError(error: error.toString()));
    });
  }
}
