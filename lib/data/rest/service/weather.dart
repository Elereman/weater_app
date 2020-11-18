import 'package:weather_app/backbone/factory.dart';
import 'package:weather_app/data/gateway/weather.dart';
import 'package:weather_app/data/model/weather.dart';
import 'package:weather_app/data/model/weather_daily_forecast.dart';
import 'package:weather_app/data/model/weather_hourly_forecast.dart';
import 'package:weather_app/domain/entity/location.dart';
import 'package:weather_app/domain/entity/weather.dart';
import 'package:weather_app/domain/entity/weather/daily_forecast.dart';
import 'package:weather_app/domain/entity/weather/hourly_forecast.dart';
import 'package:weather_app/domain/service/weather.dart';

class RestWeatherService implements WeatherService {
  final WeatherGateway _weatherGateway;
  final Factory<WeatherHourlyForecast, WeatherHourlyForecastDto>
      _weatherHourlyBoundary;
  final Factory<WeatherDailyForecast, WeatherDailyForecastDto>
      _weatherDailyBoundary;

  RestWeatherService(this._weatherGateway, this._weatherHourlyBoundary,
      this._weatherDailyBoundary);

  @override
  Future<List<WeatherDailyForecast>> getDailyWeatherForecast(
          Location location) async =>
      (await _weatherGateway.getDaily(location.latitude, location.longitude))
          .map<WeatherDailyForecast>(_weatherDailyBoundary.create)
          .toList();

  @override
  Future<List<WeatherHourlyForecast>> getHourlyWeatherForecast(
          Location location) async =>
      (await _weatherGateway.getHourly(location.latitude, location.longitude))
          .map<WeatherHourlyForecast>(_weatherHourlyBoundary.create)
          .toList();
}
