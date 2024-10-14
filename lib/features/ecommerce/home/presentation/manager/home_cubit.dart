import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../domain/home_entity/home_entity.dart';
import '../../domain/usecases/home_usecase.dart';
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
