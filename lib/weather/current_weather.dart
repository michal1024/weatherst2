import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'weather_provider.dart';
import 'model/location_forecast.dart';

class Style {
  static const summary = TextStyle(fontSize: 72);
  static const detail = TextStyle(fontSize: 24);
}

class CurrentWeather extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) => Consumer<Weather>(builder: _builder);

  Widget _builder(BuildContext ctx, Weather weather, Widget? child) {
    var weatherData = weather.at(DateTime.now())?.data;
    return weatherData == null
        ? Text('No data')
        : Column(
            children: [
              WeatherSummary(weatherData: weatherData),
              WeatherDetails(weatherData: weatherData)
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          );
  }
}

class WeatherSummary extends StatelessWidget {
  final Data weatherData;
  WeatherSummary({required this.weatherData});

  @override
  Widget build(BuildContext ctx) {
    String temp =
        weatherData.instant.details?.air_temperature?.toString() ?? '';
    String symbol = weatherData.next.summary?.symbol_code ?? 'clearsky_day';
    return Row(
      children: [
        Text('$temp℃', style: Style.summary),
        Image(image: AssetImage('images/weathericon/$symbol.png'))
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}

class Arrow extends StatelessWidget {
  final double direction;
  Arrow({required this.direction});

  @override
  Widget build(BuildContext ctx) {
    double rads = direction * pi / 180.0;
    return Transform.rotate(
        angle: rads, child: Icon(Icons.arrow_downward_rounded));
  }
}

class WeatherDetails extends StatelessWidget {
  final Data weatherData;

  WeatherDetails({required this.weatherData});

  @override
  Widget build(BuildContext ctx) {
    var details = weatherData.instant.details;
    return Row(
      children: <Widget>[
        _WindDetails(
            direction: details?.wind_from_direction ?? 0,
            speed: details?.wind_speed ?? 0),
        Text('${details?.relative_humidity} %', style: Style.detail),
        Text('${details?.air_pressure_at_sea_level} hPa', style: Style.detail)
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}

class _WindDetails extends StatelessWidget {
  final double direction;
  final double speed;

  _WindDetails({required this.direction, required this.speed});

  @override
  Widget build(BuildContext ctx) => Row(children: [
        Arrow(direction: direction),
        Text('$speed m/s', style: Style.detail),
      ]);
}
