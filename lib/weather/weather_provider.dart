import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'model/location_forecast.dart';

class Weather extends ChangeNotifier {
  LocationForecast? _forecast;
  LocationForecast? get forecast => _forecast;
  
  Weather() {
    print('Requesting');
    http
        .get(
            Uri.parse(
                'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=49.97&lon=20.15'),
            headers: {'User-Agent': 'hobby project/0 michal1024@gmail.com'})
        .then((response) => jsonDecode(response.body))
        .then(_updateForecast);
  }

  void _updateForecast(dynamic data) {
    _forecast = LocationForecast.fromJson(data);
    notifyListeners();
  }


  Timeseries? at(DateTime dt) {
    if (_forecast == null) {
      return null;
    }
    var timeseries = _forecast!.properties.timeseries;
    if (timeseries.length < 1) {
      return null;
    }
    Timeseries closest = timeseries[0];
    Duration closestDistance = dt.difference(closest.time).abs();
    for (var ts in timeseries) {
      var distance = ts.time.difference(dt).abs();
      if (distance < closestDistance) {
        closestDistance = distance;
        closest = ts;
      }
    }
    return closest;
  }

}
