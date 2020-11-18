import 'package:http/http.dart' as http;
import 'package:weather_app/data/base_rest_gateway.dart';
import 'package:weather_app/infrastructure/service/rest_cache.dart';

class BaseRestGateWayWithCaching implements BaseRestGateWay {
  final BaseRestGateWay _gateWay;
  final SharedPreferencesRestCache _cache;

  BaseRestGateWayWithCaching(this._gateWay, this._cache);

  @override
  Future<http.Response> getRequest(String baseUrl, String path, String locale,
      Map<String, String> queryParams) async {
    http.Response _response;
    try {
      _response = await _gateWay.getRequest(baseUrl, path, locale, queryParams);
    } on Object catch (_) {
      if (queryParams['exclude'].contains('hourly')) {
        return http.Response(await _cache.loadDailyCached(), 200);
      } else if (queryParams['exclude'].contains('daily')) {
        return http.Response(await _cache.loadHourlyCached(), 200);
      } else {
        rethrow;
      }
    }

    if (queryParams['exclude'].contains('hourly')) {
      _cache.cacheDaily(_response.body);
    } else if (queryParams['exclude'].contains('daily')) {
      _cache.cacheHourly(_response.body);
    }
    return _response;
  }
}
