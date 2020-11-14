import 'package:flutter/material.dart';
import 'package:weater_app/flutter/page/home.dart';
import 'package:weater_app/flutter/page/splash.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        disabledColor: Colors.deepOrange.shade900,
        buttonColor: Colors.red,
        cursorColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
    );
  }
}
