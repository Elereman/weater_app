import 'package:flutter/material.dart';
import 'package:weather_app/flutter/bloc/home_page/bloc.dart';
import 'package:weather_app/flutter/page/home.dart';

import 'package:weather_app/service_locator.dart' as di;

class SplashPage extends StatefulWidget {
  final String _title;

  const SplashPage({@required String title, Key key})
      : _title = title,
        super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/splash.png'),
    );
  }

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement<void, void>(
        MaterialPageRoute<void>(
            builder: (BuildContext context) => HomePage(
                bloc: di.sl.get<HomePageBloc>(), title: widget._title)),
      );
    });
  }
}
