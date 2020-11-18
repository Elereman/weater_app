import 'package:weather_app/data/model/temperature_forecast.dart';

class WeatherDailyForecastDto {
  final int _timeStamp;
  final TemperatureForecastDto _temp;
  final TemperatureForecastDto _feelsLike;
  final int _pressure;
  final int _humidity;
  final double _windSpeed;
  final String _weatherState;
  final String _weatherDescription;

  WeatherDailyForecastDto(
      this._timeStamp,
      this._temp,
      this._feelsLike,
      this._pressure,
      this._humidity,
      this._windSpeed,
      this._weatherState,
      this._weatherDescription);

  String get weatherDescription => _weatherDescription;

  String get weatherState => _weatherState;

  double get windSpeed => _windSpeed;

  int get humidity => _humidity;

  int get pressure => _pressure;

  TemperatureForecastDto get feelsLike => _feelsLike;

  TemperatureForecastDto get temp => _temp;

  int get timeStamp => _timeStamp;
}
