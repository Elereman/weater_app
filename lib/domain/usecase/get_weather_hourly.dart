import 'package:weather_app/domain/entity/location.dart';
import 'package:weather_app/domain/entity/weather.dart';
import 'package:weather_app/domain/entity/weather/hourly_forecast.dart';
import 'package:weather_app/domain/service/weather.dart';

abstract class GetWeatherHourlyUseCase {
  Future<List<WeatherHourlyForecast>> call(Location location);
}
class GetHourlyWeatherWithService implements GetWeatherHourlyUseCase {
  final WeatherService _weatherService;

  GetHourlyWeatherWithService(this._weatherService);

  @override
  Future<List<WeatherHourlyForecast>> call(Location location) =>
      _weatherService.getHourlyWeatherForecast(location);

}