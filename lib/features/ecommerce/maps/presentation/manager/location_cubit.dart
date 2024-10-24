import 'package:bloc/bloc.dart';
import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import '../../domain/use_case/location_use_case.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetUserLocationUseCase getUserLocationUseCase;

  LocationCubit(this.getUserLocationUseCase) : super(LocationInitial());

  Future<void> fetchUserLocation() async {
    emit(LocationLoading());

  try {
      final position = await getUserLocationUseCase.getCurrentLocation();
      safePrint("Position: $position");
      emit(LocationLoaded(position));
    } catch (e) {
      emit(LocationError("Failed to get location"));
    }
  }
}

