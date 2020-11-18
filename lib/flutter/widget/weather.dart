import 'package:flutter/material.dart';
import 'package:weather_app/domain/entity/weather/daily_forecast.dart';
import 'package:weather_app/domain/entity/weather/hourly_forecast.dart';
import 'package:easy_localization/easy_localization.dart';

class WeatherWidget extends StatefulWidget {
  final ImageProvider _image;
  final Decoration _backgroundDecoration;
  final String _firsRow, _secondRow;
  final List<String> _details = <String>[];
  final TextStyle _titleStyle;
  final TextStyle _detailsStyle;
  final double _detailsHeight;

  WeatherWidget.fromDailyWeatherForecast(
      {@required Decoration backgroundDecoration,
      @required ImageProvider image,
      @required WeatherDailyForecast weather,
      @required String secondRow,
      TextStyle titleStyle = const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      TextStyle detailStyle = const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      double detailsHeight = 150,
      Key key})
      : _firsRow = '${weather.temp.day} °C',
        _secondRow = secondRow,
        _image = image,
        _backgroundDecoration = backgroundDecoration,
        _titleStyle = titleStyle,
        _detailsStyle = detailStyle,
        _detailsHeight = detailsHeight,
        super(key: key) {
    _details.addAll(<String>[
      weather.weatherState.toString().tr(),
      weather.weatherDescription,
      '${'weather_pressure'.tr()}: ${weather.pressure} ${'weather_hPa'.tr()}',
      '${'weather_feels_like'.tr()}: ${weather.feelsLike.day} °C',
      '${'weather_wind_speed'.tr()}: ${weather.windSpeed} ${'weather_metre/sec'.tr()}',
      '${'weather_humidity'.tr()}: ${weather.humidity} %'
    ]);
  }

  WeatherWidget.fromHourlyWeatherForecast(
      {@required Decoration backgroundDecoration,
      @required ImageProvider image,
      @required WeatherHourlyForecast weather,
      TextStyle titleStyle = const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      TextStyle detailStyle = const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      double detailsHeight = 150,
      Key key})
      : _firsRow = '${weather.temp} °C',
        _secondRow =
            '${'weather_time'.tr()}: ${weather.date.hour}:${weather.date.minute}',
        _image = image,
        _backgroundDecoration = backgroundDecoration,
        _titleStyle = titleStyle,
        _detailsStyle = detailStyle,
        _detailsHeight = detailsHeight,
        super(key: key) {
    _details.addAll(<String>[
      weather.weatherState.toString().tr(),
      weather.weatherDescription,
      '${'weather_pressure'.tr()}: ${weather.pressure} ${'weather_hPa'.tr()}',
      '${'weather_feels_like'.tr()}: ${weather.feelsLike} °C',
      '${'weather_wind_speed'.tr()}: ${weather.windSpeed} ${'weather_metre/sec'.tr()}',
      '${'weather_humidity'.tr()}: ${weather.humidity} %'
    ]);
  }

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  bool isExtended = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        isExtended = !isExtended;
      }),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          decoration: widget._backgroundDecoration,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image(image: widget._image),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '${'weather_temp'.tr()}: ${widget._firsRow}',
                        textAlign: TextAlign.left,
                        style: widget._titleStyle,
                      ),
                      Text(
                        widget._secondRow,
                        textAlign: TextAlign.start,
                        style: widget._titleStyle,
                      ),
                      _WeatherDetails(
                        isShown: isExtended,
                        details: widget._details,
                        height: widget._detailsHeight,
                        detailsStyle: widget._detailsStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WeatherDetails extends StatefulWidget {
  final bool isShown;
  final List<String> details;
  final double height;
  final TextStyle detailsStyle;

  const _WeatherDetails(
      {@required this.isShown,
      @required this.details,
      @required this.height,
      @required this.detailsStyle,
      Key key})
      : super(key: key);

  @override
  _WeatherDetailsState createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<_WeatherDetails>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> sizeAnimation;
  Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        value: widget.isShown ? 1 : 0,
        duration: const Duration(milliseconds: 300));
    sizeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.decelerate,
    );
    opacityAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInQuint,
    );
  }

  @override
  void didUpdateWidget(covariant _WeatherDetails oldWidget) {
    if (oldWidget.isShown && !widget.isShown) {
      _hide();
    } else if (!oldWidget.isShown && widget.isShown) {
      _show();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = <Widget>[];
    widget.details.forEach((String detail) {
      widgets.add(Text(detail, style: widget.detailsStyle));
    });
    return FadeTransition(
      opacity: opacityAnimation,
      child: SizeTransition(
        axisAlignment: 1.0,
        sizeFactor: sizeAnimation,
        child: Container(
            height: widget.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgets,
            )),
      ),
    );
  }

  void _show() {
    _animationController.forward();
  }

  void _hide() {
    _animationController.reverse();
  }
}
