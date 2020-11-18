
import 'package:weather_app/domain/entity/location.dart';

abstract class GeolocationService {
   Future<Location> getCurrentLocation();
}