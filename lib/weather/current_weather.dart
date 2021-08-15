import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

//https://developer.yr.no/doc/
//49.97153, 20.15229
//https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=49.97&lon=20.15

class CurrentWeather extends StatefulWidget {
  @override
  State createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  double temp = 0;

  void updateTime(dynamic data) {
    setState(() {
      temp = data['properties']['timeseries'][0]['data']['instant']['details']['air_temperature'];
    });
  }

  @override
  void initState() {
    setState(() {
      http.get(Uri.parse('https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=49.97&lon=20.15'),
        headers: {'User-Agent': 'hobby project/0 michal1024@gmail.com'})
        .then((response) => jsonDecode(response.body))
        .then(updateTime);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    return Text('$temp℃', style: TextStyle(fontSize: 128),);
  }
}