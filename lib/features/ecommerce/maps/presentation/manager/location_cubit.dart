import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/use_case/get_location_use_case.dart';
import '../../domain/use_case/set_location_use_case.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetUserLocationUseCase getUserLocationUseCase;
  final SetLocationUseCase setLocationUseCase;

  LatLng? selectedLocation;

  LocationCubit(this.getUserLocationUseCase, this.setLocationUseCase)
      : super(LocationInitial());

  Future<void> fetchUserLocation() async {
    emit(LocationLoading());
    try {
      final position = await getUserLocationUseCase.getCurrentLocation();
      emit(LocationLoaded(position));
    } catch (e) {
      emit(LocationError("Failed to get location"));
    }
  }

  void setMarker(LatLng location) async {
    selectedLocation = location;
    await setLocationUseCase.setLocation(location);
    emit(LocationMarkerSet(location));
  }
}
