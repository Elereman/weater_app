class TemperatureForecastDto {
  final double _day, _min, _max, _night, _eve, _morn;

  TemperatureForecastDto(
      this._day, this._min, this._max, this._night, this._eve, this._morn);

  double get morn => _morn;

  double get eve => _eve;

  double get night => _night;

  double get max => _max;

  double get min => _min;

  double get day => _day;
}
