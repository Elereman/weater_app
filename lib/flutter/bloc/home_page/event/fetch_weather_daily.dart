import 'package:weather_app/domain/entity/location.dart';
import 'package:weather_app/domain/entity/weather.dart';
import 'package:weather_app/domain/entity/weather/daily_forecast.dart';
import 'package:weather_app/domain/entity/weather/hourly_forecast.dart';
import 'package:weather_app/domain/usecase/get_weather_daily.dart';
import 'package:weather_app/flutter/bloc/home_page/event/event.dart';
import 'package:weather_app/flutter/bloc/home_page/event/weather_fetched.dart';
import 'package:weather_app/flutter/bloc/home_page/state.dart';

class FetchWeatherDailyEvent implements HomePageEvent<HomePageState> {
  final GetWeatherDailyUseCase _getWeatherDailyUseCase;
  final Sink<HomePageEvent<HomePageState>> _eventSink;
  final Location location;

  FetchWeatherDailyEvent(
      this._getWeatherDailyUseCase, this.location, this._eventSink);

  @override
  HomePageState reduce(HomePageState state) {
    _getWeatherDailyUseCase(location)
        .then((List<WeatherDailyForecast> weather) => _eventSink.add(
            WeatherFetchedEvent(HomePageState(
                weather,
                <WeatherHourlyForecast>[],
                WeatherType.Daily,
                BlocStatus.Loaded,
                state?.location))))
        .catchError((Object error) {
      print(error);
      _eventSink.add(WeatherFetchedEvent(HomePageState(
          <WeatherDailyForecast>[],
          <WeatherHourlyForecast>[],
          WeatherType.Daily,
          BlocStatus.Error,
          state?.location)));
    });

    return HomePageState(<WeatherDailyForecast>[], <WeatherHourlyForecast>[],
        WeatherType.Daily, BlocStatus.Loading, state?.location);
  }
}
