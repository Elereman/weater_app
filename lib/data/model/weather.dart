import 'package:meta/meta.dart';

class WeatherDto {
  final double _temp;
  final double _feelsLike;
  int  _pressure;
  int  _humidity;
  final double _windSpeed;
  final int _timeStamp;
  final String _weatherState;
  final String _weatherDescription;

  WeatherDto(
      {@required double temp,
      @required double feelsLike,
      @required int pressure,
      @required int humidity,
      @required double windSpeed,
      @required int timeStamp,
      @required String weatherState,
      @required String weatherDescription})
      : _temp = temp,
        _feelsLike = feelsLike,
        _humidity = humidity,
        _pressure = pressure,
        _windSpeed = windSpeed,
        _timeStamp = timeStamp,
        _weatherState = weatherState,
        _weatherDescription = weatherDescription,
        super();

  factory WeatherDto.fromJson(Map<String, dynamic> json) => WeatherDto(
        temp: json['temp'] as double,
        feelsLike: json['feels_like'] as double,
        humidity: json['humidity'] as int,
        pressure: json['pressure'] as int,
        windSpeed: json['wind_speed'] as double,
        timeStamp: json['dt'] as int,
        weatherState: json['main'] as String,
        weatherDescription: json['description'] as String,
      );

  String get weatherDescription => _weatherDescription;

  String get weatherState => _weatherState;

  int get timeStamp => _timeStamp;

  double get windSpeed => _windSpeed;

  int get humidity => _humidity;

  int get pressure => _pressure;

  double get feelsLike => _feelsLike;

  double get temp => _temp;
}
