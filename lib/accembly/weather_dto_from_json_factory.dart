import 'package:weather_app/backbone/factory.dart';
import 'package:weather_app/data/model/weather.dart';

class DtoFromJsonFactory implements Factory<WeatherDto, Map<String, dynamic>> {
  @override
  WeatherDto create(Map<String, dynamic> json) {
    return WeatherDto(
        temp: _convertParameter(json['temp']),
        feelsLike: _convertParameter(json['feels_like']),
        pressure: json['pressure'] as int,
        humidity: json['humidity'] as int,
        windSpeed: json['wind_speed'] as double,
        timeStamp: json['dt'] as int,
        weatherState: json['main'] as String,
        weatherDescription: json['description'] as String);
  }

  double _convertParameter(dynamic parameter) {
    if(parameter is double) {
      return parameter;
    } else {
      return(parameter as Map<String, dynamic>)['max'] as double;
    }
  }
}
