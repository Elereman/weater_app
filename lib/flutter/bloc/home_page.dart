import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class HomePageBloc extends BlocBase {
  final BehaviorSubject<BlocState> _stateSubject;
  final BehaviorSubject<BlocEvent<BlocState>> _eventSubject;

  int _state;

  HomePageBloc()
      : _stateSubject = BehaviorSubject<BlocState>(),
        _eventSubject = BehaviorSubject<BlocEvent<BlocState>>(),
        super() {
    _eventSubject.listen((BlocEvent<BlocState> value) {
      _state = value.hashCode;
      _stateSubject.add(BlocState(_state));
    });
  }

  void fetchWeather() {
    _eventSubject.add(FetchWeatherEvent());
  }

  void fetchWeatherHours() {
    _eventSubject.add(FetchWeatherEvent());
  }

  void fetchWeatherDays() {
    _eventSubject.add(FetchWeatherEvent());
  }

  @override
  void dispose() {
    _stateSubject?.close();
    _eventSubject?.close();
    super.dispose();
  }
}

class FetchWeatherEvent extends BlocEvent<BlocState> {}

abstract class BlocEvent<T> {}

class BlocState {
  final int _state;

  BlocState(this._state);

  int get state => _state;
}