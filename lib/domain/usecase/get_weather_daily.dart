import 'package:weather_app/domain/entity/location.dart';
import 'package:weather_app/domain/entity/weather.dart';
import 'package:weather_app/domain/entity/weather/daily_forecast.dart';
import 'package:weather_app/domain/service/weather.dart';

abstract class GetWeatherDailyUseCase {
  Future<List<WeatherDailyForecast>> call(Location location);
}

class GetDailyWeatherWithService implements GetWeatherDailyUseCase {
  final WeatherService _weatherService;

  GetDailyWeatherWithService(this._weatherService);

  @override
  Future<List<WeatherDailyForecast>> call(Location location) =>
      _weatherService.getDailyWeatherForecast(location);
}