import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'model/location_forecast.dart';

class Weather extends ChangeNotifier {
  LocationForecast? _forecast;
  LocationForecast? get forecast => _forecast;
  Timer? _timer;
  DateTime _expires = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime _lastFetch = DateTime.fromMillisecondsSinceEpoch(0);
  Logger _logger = Logger();
  
  Weather() {
    Timer.run(_fetchForecast);
    _timer = Timer.periodic(Duration(hours: 1), (_) => _fetchForecast());
  }
  
  @override
  dispose() {
    _timer?.cancel();
    super.dispose();
  }
    
  void _fetchForecast() {
    if (_lastFetch.isBefore(_expires)) {
      _logger.i('''Skip forecast fetching, 
          expires: ${_expires.toIso8601String()}
          last fetch: ${_lastFetch.toIso8601String()}
        ''');
      return;
    }
    try {
      http.get(
          Uri.parse(
              'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=49.97&lon=20.15'),
          headers: {
            'User-Agent': 'hobby project/0 michal1024@gmail.com',
            'If-Modified-Since': HttpDate.format(_lastFetch)
          }).then(_processResponse);
    } catch (e) {
      _logger.e('Failed to fetch forecast', e);
    }
  }

  void _processResponse(http.Response response) {
    _logger.i('Fetch status code ${response.statusCode}');
    if (response.statusCode != 200) {
      return;
    }
    try {
      _updateExpiration(response);
      _updateForecast(response);
      _lastFetch = DateTime.now();
      notifyListeners();
    } catch (_) {

    }
  }

  void _updateExpiration(http.Response response) {
    if (response.headers.containsKey('Expires')) try {
      _expires = HttpDate.parse(response.headers['Expires']!);
    } catch(e) {
      _logger.e('Parsing Expires header failed', e);
      rethrow;
    }
  }

  void _updateForecast(http.Response response) {
    try {
      var data = jsonDecode(response.body);
      _forecast = LocationForecast.fromJson(data);

    } catch (e) {
      _logger.e('Failed to parse forecast response', e);
      rethrow;
    }
  }
}
