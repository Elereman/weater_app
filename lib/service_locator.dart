import 'package:get_it/get_it.dart';
import 'package:weather_app/accembly/data_domain_boundary/data/temperature_forecast_dto.dart';
import 'package:weather_app/accembly/data_domain_boundary/data/weather_daily_forecast_dto.dart';
import 'package:weather_app/accembly/data_domain_boundary/data/weather_hourly_forecast_dto.dart';
import 'package:weather_app/accembly/data_domain_boundary/model/temperature_forecast.dart';
import 'package:weather_app/accembly/data_domain_boundary/model/weather_daily_forecast.dart';
import 'package:weather_app/accembly/data_domain_boundary/model/weather_hourly_forecast.dart';
import 'package:weather_app/backbone/factory.dart';
import 'package:weather_app/data/base_rest_gatewat_with_caching.dart';
import 'package:weather_app/data/base_rest_gateway.dart';
import 'package:weather_app/data/gateway/weather.dart';
import 'package:weather_app/data/model/temperature_forecast.dart';
import 'package:weather_app/data/model/weather_daily_forecast.dart';
import 'package:weather_app/data/model/weather_hourly_forecast.dart';
import 'package:weather_app/data/rest/gateway/weather.dart';
import 'package:weather_app/data/rest/service/weather.dart';
import 'package:weather_app/domain/entity/temperature_forecast.dart';
import 'package:weather_app/domain/entity/weather/daily_forecast.dart';
import 'package:weather_app/domain/entity/weather/hourly_forecast.dart';
import 'package:weather_app/domain/service/geolocation.dart';
import 'package:weather_app/domain/service/weather.dart';
import 'package:weather_app/domain/usecase/get_position.dart';
import 'package:weather_app/domain/usecase/get_weather_daily.dart';
import 'package:weather_app/domain/usecase/get_weather_hourly.dart';
import 'package:weather_app/flutter/bloc/home_page/bloc.dart';
import 'package:weather_app/infrastructure/service/geolocation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:weather_app/infrastructure/service/rest_cache.dart';

final GetIt sl = GetIt.instance;

const String APIKEY = 'Uour OpenWeatherMap Key';
const String BASEURL = 'api.openweathermap.org';
const String PATH = '/data/2.5/onecall';
final String _locale = 'locale'.tr();

void init() {
  sl.registerLazySingleton<
          Factory<TemperatureForecast, TemperatureForecastDto>>(
      () => TemperatureForecastFromDtoFactory());
  sl.registerLazySingleton<
          Factory<TemperatureForecastDto, Map<String, dynamic>>>(
      () => TemperatureForecastDtoFromJsonFactory());
  sl.registerLazySingleton<
          Factory<WeatherDailyForecast, WeatherDailyForecastDto>>(
      () => WeatherDailyForecastFromDtoFactory(
          sl.get<Factory<TemperatureForecast, TemperatureForecastDto>>()));
  sl.registerLazySingleton<
          Factory<WeatherHourlyForecast, WeatherHourlyForecastDto>>(
      () => WeatherHourlyForecastFromDtoFactory());
  sl.registerLazySingleton<
          Factory<WeatherDailyForecastDto, Map<String, dynamic>>>(
      () => WeatherDailyForecastDtoFromJson(
          sl.get<Factory<TemperatureForecastDto, Map<String, dynamic>>>()));
  sl.registerLazySingleton<
          Factory<WeatherHourlyForecastDto, Map<String, dynamic>>>(
      () => WeatherHourlyForecastDtoFromJson());
  sl.registerLazySingleton<SharedPreferencesRestCache>(
      () => SharedPreferencesRestCache());
  sl.registerLazySingleton<BaseRestGateWay>(() => BaseRestGateWayWithCaching(
      BaseRestGateWay(), sl.get<SharedPreferencesRestCache>()));
  sl.registerLazySingleton<WeatherGateway>(() => RestWeatherGateway(
      sl.get<BaseRestGateWay>(),
      APIKEY,
      BASEURL,
      PATH,
      sl.get<Factory<WeatherHourlyForecastDto, Map<String, dynamic>>>(),
      sl.get<Factory<WeatherDailyForecastDto, Map<String, dynamic>>>(),
      _locale));
  sl.registerLazySingleton<WeatherService>(() => RestWeatherService(
      sl.get<WeatherGateway>(),
      sl.get<Factory<WeatherHourlyForecast, WeatherHourlyForecastDto>>(),
      sl.get<Factory<WeatherDailyForecast, WeatherDailyForecastDto>>()));
  sl.registerLazySingleton<GetWeatherHourlyUseCase>(
      () => GetHourlyWeatherWithService(sl.get<WeatherService>()));
  sl.registerLazySingleton<GetWeatherDailyUseCase>(
      () => GetDailyWeatherWithService(sl.get<WeatherService>()));
  sl.registerLazySingleton<GeolocationService>(
      () => FlutterGeolocationService());
  sl.registerLazySingleton<GetLocationUseCase>(
      () => GetLocationWithGeolocation(sl.get<GeolocationService>()));

  sl.registerLazySingleton<HomePageBloc>(() => HomePageBloc(
      sl.get<GetWeatherDailyUseCase>(),
      sl.get<GetWeatherHourlyUseCase>(),
      sl.get<GetLocationUseCase>()));
}
