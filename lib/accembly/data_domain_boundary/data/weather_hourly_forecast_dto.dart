import 'package:weather_app/backbone/factory.dart';
import 'package:weather_app/data/model/weather_hourly_forecast.dart';

class WeatherHourlyForecastDtoFromJson
    implements Factory<WeatherHourlyForecastDto, Map<String, dynamic>> {
  @override
  WeatherHourlyForecastDto create(Map<String, dynamic> json) {
    final List<dynamic> _weatherList = json['weather'] as List<dynamic>;
    final Map<String, dynamic> _weather =
        _weatherList.first as Map<String, dynamic>;
    return WeatherHourlyForecastDto(
        json['dt'] as int,
        _castToDouble(json['temp']),
        _castToDouble(json['feels_like']),
        json['pressure'] as int,
        json['humidity'] as int,
        _castToDouble(json['wind_speed']),
        _weather['main'] as String,
        _weather['description'] as String);
  }

  double _castToDouble(dynamic jsonDouble) {
    if (jsonDouble is double) {
      return jsonDouble;
    } else if (jsonDouble is int) {
      return jsonDouble.toDouble();
    } else {
      return 0.0;
    }
  }
}
