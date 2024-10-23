import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../domain/entity/location_entity.dart';
import '../../domain/repo_base/repo_base.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<LocationEntity> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placeMarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);

    Placemark place = placeMarks.first;
    String address = '${place.street}, ${place.locality}, ${place.country}';

    return LocationEntity(
      latitude: position.latitude,
      longitude: position.longitude,
      address: address,
    );
  }
}
