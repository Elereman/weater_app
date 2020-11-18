import 'dart:convert';

import 'package:weather_app/backbone/factory.dart';
import 'package:weather_app/data/base_rest_gateway.dart';
import 'package:weather_app/data/gateway/weather.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/model/weather_daily_forecast.dart';
import 'package:weather_app/data/model/weather_hourly_forecast.dart';

class RestWeatherGateway implements WeatherGateway {
  final BaseRestGateWay _baseRestGateWay;
  final String _baseUrl, _path, _apiKey;
  final Factory<WeatherHourlyForecastDto, Map<String, dynamic>>
      _dtoHourlyFactory;
  final Factory<WeatherDailyForecastDto, Map<String, dynamic>> _dtoDailyFactory;

  RestWeatherGateway(this._baseRestGateWay, this._apiKey, this._baseUrl,
      this._path, this._dtoHourlyFactory, this._dtoDailyFactory);

  @override
  Future<List<WeatherDailyForecastDto>> getDaily(double lat, double lng) async {
    final Map<String, String> _requestParams = <String, String>{
      'lat': lat.toString(),
      'lon': lng.toString(),
      'exclude': 'minutely,alerts,current,hourly',
      'units': 'metric',
      'appid': _apiKey
    };
    final http.Response response =
        await _baseRestGateWay.getRequest(_baseUrl, _path, _requestParams);
    final Map<String, dynamic> jsonResponse =
        json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic> _weatherJson = jsonResponse['daily'] as List<dynamic>;
    return _weatherJson
        .map((dynamic b) => _dtoDailyFactory.create(b as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<WeatherHourlyForecastDto>> getHourly(
      double lat, double lng) async {
    final Map<String, String> _requestParams = <String, String>{
      'lat': lat.toString(),
      'lon': lng.toString(),
      'exclude': 'minutely,alerts,current,daily',
      'units': 'metric',
      'appid': _apiKey
    };
    final http.Response response =
        await _baseRestGateWay.getRequest(_baseUrl, _path, _requestParams);
    final Map<String, dynamic> jsonResponse =
        json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic> _weatherJson = jsonResponse['hourly'] as List<dynamic>;
    return _weatherJson
        .map((dynamic b) => _dtoHourlyFactory.create(b as Map<String, dynamic>))
        .toList();
  }
}
