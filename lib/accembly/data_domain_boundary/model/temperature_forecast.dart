import 'package:weather_app/backbone/factory.dart';
import 'package:weather_app/data/model/temperature_forecast.dart';
import 'package:weather_app/domain/entity/temperature_forecast.dart';

class TemperatureForecastFromDtoFactory
    implements Factory<TemperatureForecast, TemperatureForecastDto> {
  @override
  TemperatureForecast create(TemperatureForecastDto args) {
    return TemperatureForecast(
        args.day, args.min, args.max, args.night, args.eve, args.morn);
  }
}
