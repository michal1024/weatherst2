import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'model/location_forecast.dart';

class Weather extends ChangeNotifier {
  LocationForecast? _forecast;
  LocationForecast? get forecast => _forecast;
  //Timer? _timer;
  DateTime _expires = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime _lastRun = DateTime.fromMillisecondsSinceEpoch(0);
  
  Weather() {
    Timer.run(_fetchForecast);
    Timer.periodic(Duration(hours: 1), (_) => _fetchForecast());
  }
    
  void _fetchForecast() {
    if (_lastRun.isBefore(_expires)) {
      return;
    }
    http
        .get(
            Uri.parse(
                'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=49.97&lon=20.15'),
            headers: {'User-Agent': 'hobby project/0 michal1024@gmail.com',
              'If-Modified-Since': HttpDate.format(_lastRun)})
        .then(_processResponse);
  }

  void _processResponse(http.Response response) {
    _updateExpiration(response);
    _updateForecast(response);
    _lastRun = DateTime.now();
    notifyListeners();
  }

  void _updateExpiration(http.Response response) {
    if (response.headers.containsKey('Expires')) try {
      _expires = HttpDate.parse(response.headers['Expires']!);
    } catch(_) {

    }
  }

  void _updateForecast(http.Response response) {
    try {
      var data = jsonDecode(response.body);
      _forecast = LocationForecast.fromJson(data);
    } catch (_) {
      
    }
  }
}
