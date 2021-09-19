import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'weather_provider.dart';
import 'weather_images.dart';
import 'model/location_forecast.dart';

class Style {
  static const summary = TextStyle(fontSize: 72);
  static const detail = TextStyle(fontSize: 24);
}

class CurrentWeather extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) => Consumer<Weather>(builder: _builder);

  Widget _builder(BuildContext ctx, Weather weather, Widget? child) {
    var currentWeather = weather.at(DateTime.now());
    return currentWeather == null
        ? Text('No data')
        : Column(
            children: [
              WeatherSummary(weather: currentWeather),
              SizedBox(height: 16,),
              WeatherDetails(weather: currentWeather)
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          );
  }
}

class WeatherSummary extends StatelessWidget {
  final Forecast weather;
  WeatherSummary({required this.weather});

  @override
  Widget build(BuildContext ctx) {
    String temp =
        weather.data.instant.details?.air_temperature?.toString() ?? '';
    return Row(
      children: [
        Text('$temp℃', style: Style.summary),
        Image.asset(WeatherImages.forecastImage(weather))
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
  final Forecast weather;

  WeatherDetails({required this.weather});

  @override
  Widget build(BuildContext ctx) {
    var details = weather.data.instant.details;
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
