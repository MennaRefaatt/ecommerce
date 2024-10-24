import 'package:geolocator/geolocator.dart';

abstract class GeolocationDataSource {
  Future<Position> getCurrentLocation();
}

class GeolocationDataSourceImpl implements GeolocationDataSource {
  @override
  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      return await Geolocator.getCurrentPosition();
    }
    throw Exception("Location permission denied");
  }
}
