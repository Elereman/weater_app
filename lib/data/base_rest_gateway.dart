import 'package:http/http.dart' as http;

class BaseRestGateWay {
  Future<http.Response> getRequest(String baseUrl, String path, String locale,
      Map<String, String> queryParams) {
    final Map<String, String> queryParamsWithLocale = queryParams;
    queryParamsWithLocale.addAll(<String, String>{'lang': locale});
    return http.get(Uri.https(baseUrl, path, queryParamsWithLocale).toString());
  }
}
