import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:geolocator/geolocator.dart';
import '../../domain/repo_base/repo_base.dart';
import '../data_source/data_source.dart';

class LocationRepositoryImpl implements LocationRepository {
  final GeolocationDataSource dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<Position> getCurrentLocation() {
    final position = dataSource.getCurrentLocation();
    try {
      safePrint(position.toString());
     return position;
    } catch (e) {
      return Future.error(e);
    }
  }
}
