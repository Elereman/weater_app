import 'package:weather_app/domain/entity/location.dart';
import 'package:weather_app/domain/entity/weather/daily_forecast.dart';
import 'package:weather_app/domain/entity/weather/hourly_forecast.dart';

abstract class WeatherService {
  Future<List<WeatherDailyForecast>> getDailyWeatherForecast(Location location);

  Future<List<WeatherHourlyForecast>> getHourlyWeatherForecast(
      Location location);
}
