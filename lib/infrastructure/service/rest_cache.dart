import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRestCache {
  Future<void> cacheHourly(String body) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('Hourly', body);
  }

  Future<void> cacheDaily(String body) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('Daily', body);
  }

  Future<String> loadHourlyCached() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('Hourly');
  }

  Future<String> loadDailyCached() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('Daily');
  }
}
