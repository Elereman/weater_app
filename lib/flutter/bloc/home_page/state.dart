import 'package:weather_app/domain/entity/location.dart';
import 'package:weather_app/domain/entity/weather.dart';
import 'package:weather_app/domain/entity/weather/daily_forecast.dart';
import 'package:weather_app/domain/entity/weather/hourly_forecast.dart';

class HomePageState {
  final List<WeatherDailyForecast> _weatherDailyList;
  final List<WeatherHourlyForecast> _weatherHourlyList;
  final WeatherType _weatherType;
  final BlocStatus _status;
  final Location location;

  HomePageState(this._weatherDailyList, this._weatherHourlyList,
      this._weatherType, this._status, this.location);

  List<WeatherDailyForecast> get weatherDailyList => _weatherDailyList;

  List<WeatherHourlyForecast> get weatherHourlyList => _weatherHourlyList;

  BlocStatus get status => _status;

  WeatherType get weatherType => _weatherType;
}

enum WeatherType { Hourly, Daily }

enum BlocStatus { Loading, Loaded, Error }
