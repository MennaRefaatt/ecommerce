part of 'location_cubit.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final Position position;
  final String address;
  LocationLoaded(this.position, this.address);
}

class LocationMarkerSet extends LocationState {
  final LatLng location;
  final String address;

  LocationMarkerSet(this.location, this.address);
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}
