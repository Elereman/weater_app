class TemperatureForecast {
  final double _day;
  final double _min;
  final double _max;
  final double _night;
  final double _evening;
  final double _morning;

  TemperatureForecast(this._day, this._min, this._max, this._night,
      this._evening, this._morning);

  double get morning => _morning;

  double get evening => _evening;

  double get night => _night;

  double get max => _max;

  double get min => _min;

  double get day => _day;
}
