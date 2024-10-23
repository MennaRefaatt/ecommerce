import '../entity/location_entity.dart';

abstract class LocationRepository {
  Future<LocationEntity> getCurrentLocation();
}
