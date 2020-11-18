import 'package:http/http.dart' as http;

class BaseRestGateWay {
  Future<http.Response> getRequest(
          String baseUrl, String path, Map<String, String> queryParams) =>
      http.get(Uri.https(baseUrl, path, queryParams).toString());
}
