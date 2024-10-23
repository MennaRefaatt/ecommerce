import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/location_entity.dart';
import '../../domain/use_case/location_use_case.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetUserLocationUseCase getUserLocationUseCase;

  LocationCubit(this.getUserLocationUseCase) : super(LocationInitial());

  Future<void> fetchUserLocation() async {
    try {
      emit(LocationLoading());
      final location = await getUserLocationUseCase.execute();
      emit(LocationLoaded(location));
    } catch (e) {
      emit(LocationError('Failed to fetch location'));
    }
  }
}

