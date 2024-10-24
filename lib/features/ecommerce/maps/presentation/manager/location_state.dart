part of 'location_cubit.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  // final LocationEntity location;
  //
  // LocationLoaded(this.location);
  final Position position;
  LocationLoaded(this.position);
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}