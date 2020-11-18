import 'package:weather_app/domain/entity/temperature_forecast.dart';
import 'package:weather_app/flutter/weather_states.dart';

class WeatherDailyForecast {
  final DateTime _date;
  final TemperatureForecast _temp;
  final TemperatureForecast _feelsLike;
  final WeatherState _weatherState;
  final int _pressure;
  final int _humidity;
  final double _windSpeed;
  final String _weatherDescription;


  WeatherDailyForecast(this._date, this._temp, this._feelsLike,
      this._weatherState, this._pressure, this._humidity, this._windSpeed,
      this._weatherDescription);

  String get weatherDescription => _weatherDescription;

  double get windSpeed => _windSpeed;

  int get humidity => _humidity;

  int get pressure => _pressure;

  WeatherState get weatherState => _weatherState;

  TemperatureForecast get feelsLike => _feelsLike;

  TemperatureForecast get temp => _temp;

  DateTime get date => _date;
}