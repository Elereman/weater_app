import 'package:weather_app/domain/entity/location.dart';
import 'package:weather_app/domain/usecase/get_position.dart';
import 'package:weather_app/flutter/bloc/home_page/event/event.dart';
import 'package:weather_app/flutter/bloc/home_page/event/location_geted.dart';
import 'package:weather_app/flutter/bloc/home_page/state.dart';

class GetLocationEvent implements HomePageEvent<HomePageState> {
  final GetLocationUseCase _getLocationUseCase;
  final Sink<HomePageEvent<HomePageState>> _eventSink;

  GetLocationEvent(this._getLocationUseCase, this._eventSink);

  @override
  HomePageState reduce(HomePageState state) {
    _getLocationUseCase()
        .then((Location location) => _eventSink.add(LocationGetedEvent(
            HomePageState(state?.weatherDailyList, state?.weatherHourlyList,
                state?.weatherType, BlocStatus.Loaded, location))))
        .catchError((Object error) => _eventSink.add(LocationGetedEvent(
            HomePageState(state?.weatherDailyList, state?.weatherHourlyList,
                state?.weatherType, BlocStatus.Error, null))));
    return HomePageState(state?.weatherDailyList, state?.weatherHourlyList,
        state?.weatherType, BlocStatus.Loading, null);
  }
}
