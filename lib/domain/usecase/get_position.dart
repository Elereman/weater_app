import 'package:weather_app/domain/entity/location.dart';
import 'package:weather_app/domain/service/geolocation.dart';

abstract class GetLocationUseCase {
  Future<Location> call();
}

class GetLocationWithGeolocation implements GetLocationUseCase {
  final GeolocationService _geolocationService;

  GetLocationWithGeolocation(this._geolocationService);

  @override
  Future<Location> call() => _geolocationService.getCurrentLocation();
}
