import 'package:weather_app/domain/entity/location.dart';
import 'package:weather_app/domain/entity/weather.dart';
import 'package:weather_app/domain/entity/weather/daily_forecast.dart';
import 'package:weather_app/domain/entity/weather/hourly_forecast.dart';
import 'package:weather_app/domain/usecase/get_weather_hourly.dart';
import 'package:weather_app/flutter/bloc/home_page/event/event.dart';
import 'package:weather_app/flutter/bloc/home_page/event/weather_fetched.dart';
import 'package:weather_app/flutter/bloc/home_page/state.dart';

class FetchWeatherHourlyEvent implements HomePageEvent<HomePageState> {
  final GetWeatherHourlyUseCase _getWeatherHourlyUseCase;
  final Sink<HomePageEvent<HomePageState>> _eventSink;
  final Location location;

  FetchWeatherHourlyEvent(
      this._getWeatherHourlyUseCase, this.location, this._eventSink);

  @override
  HomePageState reduce(HomePageState state) {
    _getWeatherHourlyUseCase(location)
        .then((List<WeatherHourlyForecast> weather) => _eventSink.add(
            WeatherFetchedEvent(HomePageState(<WeatherDailyForecast>[], weather,
                WeatherType.Hourly, BlocStatus.Loaded, state?.location))))
        .catchError((Object error) => _eventSink.add(WeatherFetchedEvent(
            HomePageState(<WeatherDailyForecast>[], <WeatherHourlyForecast>[],
                WeatherType.Hourly, BlocStatus.Error, state?.location))));

    return HomePageState(<WeatherDailyForecast>[], <WeatherHourlyForecast>[],
        WeatherType.Hourly, BlocStatus.Loading, state?.location);
  }
}
