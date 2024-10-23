import '../entity/location_entity.dart';
import '../repo_base/repo_base.dart';

class GetUserLocationUseCase {
  final LocationRepository repository;

  GetUserLocationUseCase(this.repository);

  Future<LocationEntity> execute() async {
    return await repository.getCurrentLocation();
  }
}
