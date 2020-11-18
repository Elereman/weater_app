import 'package:geolocator/geolocator.dart';
import 'package:weather_app/domain/entity/location.dart';
import 'package:weather_app/domain/service/geolocation.dart';

class FlutterGeolocationService implements GeolocationService{
  @override
  Future<Location> getCurrentLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return Location(position.longitude, position.latitude);
    } on Object {
      return Location(25.68, 16.78);
    }
  }
}