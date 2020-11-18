import 'package:meta/meta.dart';
import 'package:weather_app/domain/entity/temperature_forecast.dart';
import 'package:weather_app/flutter/weather_states.dart';

class Weather {
  final double _temp;
  final double _feelsLike;
  final int _pressure;
  final int _humidity;
  final double _windSpeed;
  final DateTime _timeStamp;
  final String _weatherText;
  final String _weatherDescription;
  final WeatherState _weatherState;

  Weather(
      {@required double temp,
      @required double feelsLike,
      @required int pressure,
      @required int humidity,
      @required double windSpeed,
      @required DateTime timeStamp,
      @required String weatherText,
      @required WeatherState weatherState,
      @required String weatherDescription})
      : _temp = temp,
        _feelsLike = feelsLike,
        _humidity = humidity,
        _pressure = pressure,
        _windSpeed = windSpeed,
        _timeStamp = timeStamp,
        _weatherText = weatherText,
        _weatherState = weatherState,
        _weatherDescription = weatherDescription,
        super();

  String get weatherDescription => _weatherDescription;

  String get weatherText => _weatherText;

  DateTime get timeStamp => _timeStamp;

  double get windSpeed => _windSpeed;

  int get humidity => _humidity;

  int get pressure => _pressure;

  double get feelsLike => _feelsLike;

  double get temp => _temp;

  WeatherState get weatherState => _weatherState;
}
