import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'model/location_forecast.dart';

//https://developer.yr.no/doc/
//49.97153, 20.15229
//https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=49.97&lon=20.15

class Weather extends ChangeNotifier {
  LocationForecast? _forecast;
  LocationForecast? get forecast => _forecast;

  void updateTime(dynamic data) {
    _forecast = LocationForecast.fromJson(data);
    notifyListeners();
  }

  Weather() {
    print('Requesting');
    http
        .get(
            Uri.parse(
                'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=49.97&lon=20.15'),
            headers: {'User-Agent': 'hobby project/0 michal1024@gmail.com'})
        .then((response) => jsonDecode(response.body))
        .then(updateTime);
  }
}
