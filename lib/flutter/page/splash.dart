import 'package:flutter/material.dart';
import 'package:weater_app/flutter/page/home.dart';

class SplashPage extends StatefulWidget {
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
      Navigator.of(context).pushReplacement<void, void>(MaterialPageRoute<void>(
          builder: (BuildContext context) => HomePage()));
    });
  }
}
