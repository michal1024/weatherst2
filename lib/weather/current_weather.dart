import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'weather_provider.dart';
import 'model/location_forecast.dart';

class CurrentWeather extends StatelessWidget {
  final _mainStyle = TextStyle(fontSize: 72);
  final _detailStyle = TextStyle(fontSize: 24);
  @override
  Widget build(BuildContext ctx) {
    return Consumer<Weather>(
        builder: (context, weather, child) => buildWidget(weather));
  }

  Widget buildWidget(Weather weather) {
    var data = weather.forecast?.properties.timeseries[0].data;
    var now = data?.instant;
    var next = data?.next_1_hours ?? data?.next_6_hours ?? data?.next_12_hours;
    return now == null
        ? Text('No data')
        : Column(
            children: [
              currentTempAndIcon(now, next), 
              conditions(now, next)],
            mainAxisAlignment: MainAxisAlignment.center,
          );
  }

  Widget currentTempAndIcon(DataEntry now, DataEntry? next) {
    return Row(
      children: [
        temperature(now), 
        if (next != null) icon(next)],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  Widget temperature(DataEntry now) {
    return Text('${now.details?.air_temperature}℃',
        style: _mainStyle);
  }

  Widget icon(DataEntry next) {
    var symbol = next.summary?.symbol_code ?? 'clearsky_day';
    return Image(image: AssetImage('images/weathericon/$symbol.png'));
  }

//arrow_downward_rounded
  Widget conditions(DataEntry now, DataEntry? next) {
    return Row(
      children: <Widget>[
        windSpeedDir(now),
        humidity(now),
        pressure(now),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  Widget windSpeedDir(DataEntry now) {
    double direction = now.details?.wind_from_direction ?? 0;
    double rads = direction * pi / 180.0;
    return Row(children: [
      Transform.rotate(angle: rads, child: Icon(Icons.arrow_downward_rounded)),
      Text('${now.details?.wind_speed} m/s', style: _detailStyle),
    ]);
  }

  Widget humidity(DataEntry now) {
    return Text('${now.details?.relative_humidity} %', style: _detailStyle);
  }

  Widget pressure(DataEntry now) {
    return Text('${now.details?.air_pressure_at_sea_level} hPa', style: _detailStyle);
  }
}
