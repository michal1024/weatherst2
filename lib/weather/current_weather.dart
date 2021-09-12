import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'weather_provider.dart';
import 'model/location_forecast.dart';

class CurrentWeather extends StatelessWidget {
  final _detailStyle = TextStyle(fontSize: 24);

  @override
  Widget build(BuildContext ctx) => Consumer<Weather>(builder: _builder);

  Widget _builder(BuildContext ctx, Weather weather, Widget? child) {
    /*TODO:
    change .now and .next to .at(Datetime)
    return new DataEntry that combines parameters from now.instant and summary from next.summary
    */
    var now = weather.now;
    return now == null
        ? Text('No data')
        : Column(
            children: [CurrentCondition(now: now, next:weather.next), 
            conditions(now, weather.next)],
            mainAxisAlignment: MainAxisAlignment.center,
          );
  }

  Widget conditions(DataEntry now, DataEntry? next) => Row(
        children: <Widget>[
          windSpeedDir(now),
          humidity(now),
          pressure(now),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      );

  Widget windSpeedDir(DataEntry now) => Row(children: [
        Arrow(direction: now.details?.wind_from_direction ?? 0),
        Text('${now.details?.wind_speed} m/s', style: _detailStyle),
      ]);

  Widget humidity(DataEntry now) =>
      Text('${now.details?.relative_humidity} %', style: _detailStyle);

  Widget pressure(DataEntry now) =>
      Text('${now.details?.air_pressure_at_sea_level} hPa',
          style: _detailStyle);
}

class CurrentCondition extends StatelessWidget {
  final DataEntry now;
  final DataEntry? next;
  CurrentCondition({required this.now, this.next});

  @override
  Widget build(BuildContext ctx) {
    String temp = now.details?.air_temperature?.toString() ?? '';
    String symbol = next?.summary?.symbol_code ?? 'clearsky_day';
    return Row(
        children: [
          Text('$temp℃', style: TextStyle(fontSize: 72)), 
          Image(image: AssetImage('images/weathericon/$symbol.png'))],
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
