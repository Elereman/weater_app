import 'package:weather_app/backbone/factory.dart';
import 'package:weather_app/data/model/weather.dart';
import 'package:weather_app/domain/entity/weather.dart';
import 'package:weather_app/flutter/weather_states.dart';

class WeatherFromDtoFactory implements Factory<Weather, WeatherDto> {
  @override
  Weather create(WeatherDto dto) => Weather(
      temp: dto.temp,
      feelsLike: dto.feelsLike,
      pressure: dto.pressure,
      humidity: dto.humidity,
      windSpeed: dto.windSpeed,
      timeStamp: DateTime.fromMillisecondsSinceEpoch(dto.timeStamp * 1000),
      weatherText: dto.weatherState,
      weatherDescription: dto.weatherDescription,
      weatherState: _getWeatherStateFromString(dto.weatherState));

  WeatherState _getWeatherStateFromString(String string) {
    switch (string) {
      case 'Rain':
        return WeatherState.Rain;
        break;
      case 'Thunderstorm':
        return WeatherState.Thunderstorm;
        break;
      case 'Drizzle':
        return WeatherState.Drizzle;
        break;
      case 'Snow':
        return WeatherState.Snow;
        break;
      case 'Clear':
        return WeatherState.Clear;
        break;
      case 'Clouds':
        return WeatherState.Clouds;
        break;
      case 'Mist':
        return WeatherState.Mist;
        break;
      default:
        return WeatherState.Clear;
        break;
    }
  }
}
