import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'model/location_forecast.dart';

class Weather extends ChangeNotifier {
  LocationForecast? _forecast;
  LocationForecast? get forecast => _forecast;

  DataEntry? get now => forecast?.properties.timeseries[0].data.instant;

  DataEntry? get next {
    var data = forecast?.properties.timeseries[0].data;
    return data?.next_1_hours ?? data?.next_6_hours ?? data?.next_12_hours;
  }

  void updateForecast(dynamic data) {
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
        .then(updateForecast);
  }
}
