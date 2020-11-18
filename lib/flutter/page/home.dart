import 'package:flutter/material.dart';
import 'package:weather_app/flutter/bloc/home_page/bloc.dart';
import 'package:weather_app/flutter/bloc/home_page/state.dart';
import 'package:weather_app/domain/entity/weather/weather_states.dart';
import 'package:weather_app/flutter/widget/mode_select.dart';
import 'package:weather_app/flutter/widget/weather.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatelessWidget {
  final HomePageBloc _bloc;
  final String _title;

  HomePage({@required HomePageBloc bloc, @required String title, Key key})
      : _bloc = bloc,
        _title = title,
        super(key: key) {
    _bloc.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HomePageState>(
        stream: _bloc.stateStream,
        builder: (BuildContext context, AsyncSnapshot<HomePageState> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.status == BlocStatus.Loaded) {
              return Scaffold(
                appBar: AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_title),
                      ModeSelectWidget(
                        key: ObjectKey(snapshot.data.weatherType),
                        value: snapshot.data.weatherType == WeatherType.Hourly
                            ? 'mode_hourly'.tr()
                            : 'mode_daily'.tr(),
                        onChanged: (String mode) {
                          if (mode == 'mode_daily'.tr()) {
                            _bloc.fetchWeatherDaily(snapshot.data.location);
                          } else if (mode == 'mode_hourly'.tr()) {
                            _bloc.fetchWeatherHourly(snapshot.data.location);
                          }
                        },
                        modes: <String>['mode_daily'.tr(), 'mode_hourly'.tr()],
                      ),
                    ],
                  ),
                ),
                body: snapshot.data.weatherType == WeatherType.Hourly
                    ? ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        itemCount: snapshot.data.weatherHourlyList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 3),
                            child: WeatherWidget.fromHourlyWeatherForecast(
                              backgroundDecoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/background.jpg'),
                                      fit: BoxFit.cover),
                                  color: Colors.white),
                              image: _determinateIconForWidget(snapshot
                                  .data.weatherHourlyList[index].weatherState),
                              weather: snapshot.data.weatherHourlyList[index],
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        itemCount: snapshot.data.weatherDailyList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 3),
                            child: WeatherWidget.fromDailyWeatherForecast(
                              backgroundDecoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/background.jpg'),
                                      fit: BoxFit.cover),
                                  color: Colors.white),
                              image: _determinateIconForWidget(snapshot
                                  .data.weatherDailyList[index].weatherState),
                              weather: snapshot.data.weatherDailyList[index],
                              secondRow: _weekdayFromInt(snapshot
                                  .data.weatherDailyList[index].date.weekday),
                            ),
                          );
                        },
                      ),
              );
            } else if (snapshot.data.status == BlocStatus.Error) {
              return Scaffold(
                appBar: AppBar(),
                body: Stack(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'app_error'.tr(),
                        style: const TextStyle(color: Colors.red, fontSize: 22),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: MaterialButton(
                        color: Colors.red,
                        child: Text('app_retry'.tr()),
                        onPressed: () => snapshot.data.weatherType ==
                                WeatherType.Hourly
                            ? _bloc.fetchWeatherHourly(snapshot.data.location)
                            : _bloc.fetchWeatherDaily(snapshot.data.location),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          } else {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  String _weekdayFromInt(int day) {
    switch (day) {
      case 1:
        return 'weather_day_monday'.tr();
        break;
      case 2:
        return 'weather_day_tuesday'.tr();
        break;
      case 3:
        return 'weather_day_wednesday'.tr();
        break;
      case 4:
        return 'weather_day_thursday'.tr();
        break;
      case 5:
        return 'weather_day_friday'.tr();
        break;
      case 6:
        return 'weather_day_saturday'.tr();
        break;
      case 7:
        return 'weather_day_sunday'.tr();
        break;
      default:
        return 'Unknown';
        break;
    }
  }

  ImageProvider _determinateIconForWidget(WeatherState state) {
    switch (state) {
      case WeatherState.Thunderstorm:
        return const AssetImage('assets/icons/thunderstorm.png');
        break;
      case WeatherState.Drizzle:
        return const AssetImage('assets/icons/drizzle.png');
        break;
      case WeatherState.Rain:
        return const AssetImage('assets/icons/rain.png');
        break;
      case WeatherState.Snow:
        return const AssetImage('assets/icons/snow.png');
        break;
      case WeatherState.Clear:
        return const AssetImage('assets/icons/clear.png');
        break;
      case WeatherState.Clouds:
        return const AssetImage('assets/icons/clouds.png');
        break;
      case WeatherState.Mist:
        return const AssetImage('assets/icons/mist.png');
        break;
      case WeatherState.Fog:
        return const AssetImage('assets/icons/mist.png');
        break;
      case WeatherState.Tornado:
        return const AssetImage('assets/icons/mist.png');
        break;
      case WeatherState.Squall:
        return const AssetImage('assets/icons/mist.png');
        break;
      case WeatherState.Haze:
        return const AssetImage('assets/icons/mist.png');
        break;
      case WeatherState.Dust:
        return const AssetImage('assets/icons/mist.png');
        break;
      case WeatherState.Sand:
        return const AssetImage('assets/icons/mist.png');
        break;
      case WeatherState.Ash:
        return const AssetImage('assets/icons/mist.png');
        break;
      case WeatherState.Smoke:
        return const AssetImage('assets/icons/mist.png');
        break;
      default:
        return const AssetImage('assets/icons/clear.png');
        break;
    }
  }
}
