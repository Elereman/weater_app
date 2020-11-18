class WeatherHourlyForecastDto {
  final int _timeStamp;
  final double _temp;
  final double _feelsLike;
  final int _pressure;
  final int _humidity;
  final double _windSpeed;
  final String _weatherState;
  final String _weatherDescription;

  WeatherHourlyForecastDto(
      this._timeStamp,
      this._temp,
      this._feelsLike,
      this._pressure,
      this._humidity,
      this._windSpeed,
      this._weatherState,
      this._weatherDescription);

  String get weatherDescription => _weatherDescription;

  String get weatherState => _weatherState;

  double get windSpeed => _windSpeed;

  int get humidity => _humidity;

  int get pressure => _pressure;

  double get feelsLike => _feelsLike;

  double get temp => _temp;

  int get timeStamp => _timeStamp;
}
