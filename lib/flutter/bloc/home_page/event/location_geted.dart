import 'package:weather_app/flutter/bloc/home_page/event/event.dart';
import 'package:weather_app/flutter/bloc/home_page/state.dart';

class LocationGetedEvent implements HomePageEvent<HomePageState> {
  final HomePageState _state;

  LocationGetedEvent(this._state);

  @override
  HomePageState reduce(HomePageState state) => _state;
}
