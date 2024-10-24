import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/ecommerce/product_details/data/repo_impl/pdetails_repo_impl.dart';
import 'package:flutter/cupertino.dart';
import '../../data/model/product_details_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.pDetailsRepoImpl) : super(ProductDetailsInitial());
  PDetailsRepoImpl pDetailsRepoImpl;
  void getProductDetails({required int productId}) async{
    emit(ProductDetailsLoading());
    final response = await pDetailsRepoImpl.getProductDetails(productId: productId);
    if(response.status == true){
      emit(ProductDetailsSuccess(productDetailsModel: response));
    } else {
      emit(ProductDetailsError(error: response.data.toString()));
    }
  }
}
