import 'package:bloc/bloc.dart';
import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/features/home/domain/hom_entity/home_entity.dart';
import 'package:ecommerce/features/home/domain/usecases/home_usecase.dart';
import 'package:meta/meta.dart';
import '../../data/models/home_model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeUseCase) : super(HomeInitial());
  final HomeUseCase homeUseCase;

  getHomeData() async {
    emit(HomeLoading());
    final result = await homeUseCase.getHomeData();
    if (result.status == true) {
      emit(HomeSuccess(homeEntity: result));
    } else {
      emit(HomeFailure(error: result.data.toString()));
    }
  }
}
