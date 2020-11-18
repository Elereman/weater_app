import 'package:weather_app/data/model/weather_daily_forecast.dart';
import 'package:weather_app/data/model/weather_hourly_forecast.dart';

abstract class WeatherGateway {
  Future<List<WeatherHourlyForecastDto>> getHourly(double lat, double lng);

  Future<List<WeatherDailyForecastDto>> getDaily(double lat, double lng);
}
