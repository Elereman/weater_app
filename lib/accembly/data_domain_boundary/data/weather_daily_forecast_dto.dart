import 'package:weather_app/backbone/factory.dart';
import 'package:weather_app/data/model/temperature_forecast.dart';
import 'package:weather_app/data/model/weather_daily_forecast.dart';

class WeatherDailyForecastDtoFromJson
    implements Factory<WeatherDailyForecastDto, Map<String, dynamic>> {
  final Factory<TemperatureForecastDto, Map<String, dynamic>>
      _temperatureForecastDtoFactory;

  WeatherDailyForecastDtoFromJson(this._temperatureForecastDtoFactory);

  @override
  WeatherDailyForecastDto create(Map<String, dynamic> json) {
    final List<dynamic> _weatherList = json['weather'] as List<dynamic>;
    final Map<String, dynamic> _weather =
        _weatherList.first as Map<String, dynamic>;
    return WeatherDailyForecastDto(
        json['dt'] as int,
        _temperatureForecastDtoFactory
            .create(json['temp'] as Map<String, dynamic>),
        _temperatureForecastDtoFactory
            .create(json['feels_like'] as Map<String, dynamic>),
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
