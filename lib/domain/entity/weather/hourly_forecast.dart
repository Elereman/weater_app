import 'package:weather_app/domain/entity/weather/weather_states.dart';

class WeatherHourlyForecast {
  final DateTime _date;
  final double _temp;
  final double _feelsLike;
  final WeatherState _weatherState;
  final int _pressure;
  final int _humidity;
  final double _windSpeed;
  final String _weatherDescription;


  WeatherHourlyForecast(this._date, this._temp, this._feelsLike,
      this._weatherState, this._pressure, this._humidity, this._windSpeed,
      this._weatherDescription);

  String get weatherDescription => _weatherDescription;

  double get windSpeed => _windSpeed;

  int get humidity => _humidity;

  int get pressure => _pressure;

  WeatherState get weatherState => _weatherState;

  double get feelsLike => _feelsLike;

  double get temp => _temp;

  DateTime get date => _date;
}
