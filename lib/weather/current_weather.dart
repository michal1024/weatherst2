import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'weather_provider.dart';

class CurrentWeather extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Consumer<Weather>(
      builder: (context, weather, child) => Column(children: [
        Text('${weather.forecast?.properties.timeseries[0].data.instant.details?.air_temperature}℃', style: TextStyle(fontSize: 128)),
        Text('Lat: ${weather.forecast?.geometry.coordinates[0]}, Lon: ${weather.forecast?.geometry.coordinates[1]}, Alt: ${weather.forecast?.geometry.coordinates[2]}'),]
      )
    );
  }
}
