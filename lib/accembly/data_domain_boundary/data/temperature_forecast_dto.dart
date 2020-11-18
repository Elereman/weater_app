import 'package:weather_app/backbone/factory.dart';
import 'package:weather_app/data/model/temperature_forecast.dart';

class TemperatureForecastDtoFromJsonFactory
    implements Factory<TemperatureForecastDto, Map<String, dynamic>> {
  @override
  TemperatureForecastDto create(Map<String, dynamic> json) {
    return TemperatureForecastDto(
      _castToDouble(json['day']),
      _castToDouble(json['min']),
      _castToDouble(json['max']),
      _castToDouble(json['night']),
      _castToDouble(json['eve']),
      _castToDouble(json['morn']),
    );
  }

 double _castToDouble(dynamic jsonDouble) {
    if(jsonDouble is double) {
      return jsonDouble;
    } else if (jsonDouble is int) {
      return jsonDouble.toDouble();
    } else {
      return 0.0;
    }
 }
}
