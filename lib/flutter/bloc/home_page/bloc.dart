import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/domain/entity/location.dart';
import 'package:weather_app/domain/usecase/get_position.dart';
import 'package:weather_app/domain/usecase/get_weather_daily.dart';
import 'package:weather_app/domain/usecase/get_weather_hourly.dart';
import 'package:weather_app/flutter/bloc/home_page/event/event.dart';
import 'package:weather_app/flutter/bloc/home_page/event/fetch_weather_daily.dart';
import 'package:weather_app/flutter/bloc/home_page/event/fetch_weather_hourly.dart';
import 'package:weather_app/flutter/bloc/home_page/event/get_location.dart';
import 'package:weather_app/flutter/bloc/home_page/event/initialize.dart';
import 'package:weather_app/flutter/bloc/home_page/state.dart';

class HomePageBloc extends BlocBase {
  final BehaviorSubject<HomePageState> _stateSubject;
  final BehaviorSubject<HomePageEvent<HomePageState>> _eventSubject;

  final GetWeatherDailyUseCase _getWeatherDailyUseCase;
  final GetWeatherHourlyUseCase _getWeatherHourlyUseCase;
  final GetLocationUseCase _getLocationUseCase;

  HomePageBloc(this._getWeatherDailyUseCase, this._getWeatherHourlyUseCase,
      this._getLocationUseCase)
      : _stateSubject = BehaviorSubject<HomePageState>(),
        _eventSubject = BehaviorSubject<HomePageEvent<HomePageState>>(),
        super() {
    _eventSubject.listen((HomePageEvent<HomePageState> value) {
      _stateSubject.add(value.reduce(_stateSubject.value));
    });
  }

  void fetchWeatherHourly(Location location) {
    _eventSubject.add(FetchWeatherHourlyEvent(
        _getWeatherHourlyUseCase, location, _eventSubject.sink));
  }

  void fetchWeatherDaily(Location location) {
    _eventSubject.add(FetchWeatherDailyEvent(
        _getWeatherDailyUseCase, location, _eventSubject.sink));
  }

  void getLocation() {
    _eventSubject
        .add(GetLocationEvent(_getLocationUseCase, _eventSubject.sink));
  }

  void initialize() {
    _eventSubject.add(InitializeEvent(
        _getLocationUseCase, _getWeatherDailyUseCase, _eventSubject.sink));
  }

  Stream<HomePageState> get stateStream => _stateSubject.stream;

  @override
  void dispose() {
    _stateSubject?.close();
    _eventSubject?.close();
    super.dispose();
  }
}
