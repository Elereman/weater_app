import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/flutter/page/splash.dart';
import 'package:weather_app/service_locator.dart' as di;

void main() {
  di.init();
  runApp(EasyLocalization(
    supportedLocales: const <Locale>[Locale('en'), Locale('ru')],
    path: 'assets/translations',
    useOnlyLangCode: true,
    fallbackLocale: const Locale('en'),
    child: WeatherApp(),
  ));
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        disabledColor: Colors.deepOrange.shade900,
        buttonColor: Colors.red,
        cursorColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashPage(title: 'Weather App'),
    );
  }
}
