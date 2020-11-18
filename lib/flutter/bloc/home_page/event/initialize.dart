import 'package:weather_app/domain/entity/location.dart';
import 'package:weather_app/domain/entity/weather/daily_forecast.dart';
import 'package:weather_app/domain/entity/weather/hourly_forecast.dart';
import 'package:weather_app/domain/usecase/get_position.dart';
import 'package:weather_app/domain/usecase/get_weather_daily.dart';
import 'package:weather_app/flutter/bloc/home_page/event/event.dart';
import 'package:weather_app/flutter/bloc/home_page/event/weather_fetched.dart';
import 'package:weather_app/flutter/bloc/home_page/state.dart';

class InitializeEvent extends HomePageEvent<HomePageState> {
  final GetLocationUseCase _getLocationUseCase;
  final GetWeatherDailyUseCase _getWeatherDailyUseCase;
  final Sink<HomePageEvent<HomePageState>> _eventSink;

  InitializeEvent(
      this._getLocationUseCase, this._getWeatherDailyUseCase, this._eventSink);

  @override
  HomePageState reduce(HomePageState state) {
    _getLocationUseCase()
        .then((Location location) => _getWeatherDailyUseCase(location).then(
            (List<WeatherDailyForecast> weather) => _eventSink.add(
                WeatherFetchedEvent(HomePageState(
                    weather,
                    <WeatherHourlyForecast>[],
                    WeatherType.Daily,
                    BlocStatus.Loaded,
                    location)))))
        .catchError((Object error) => _eventSink.add(WeatherFetchedEvent(
            HomePageState(null, null, null, BlocStatus.Error, null))));
    return HomePageState(
        null, null, WeatherType.Daily, BlocStatus.Loading, null);
  }
}
