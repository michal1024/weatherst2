import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'model/location_forecast.dart';
import 'package:weatherst2/app_config.dart';

class Weather extends ChangeNotifier {
  AppConfig _config;
  LocationForecast? _forecast;
  LocationForecast? get forecast => _forecast;
  Timer? _timer;
  DateTime _expires = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime _lastFetch = DateTime.fromMillisecondsSinceEpoch(0);
  Logger _logger = Logger();
  
  Weather(AppConfig config) : _config=config {
    Timer.run(_fetchForecast);
    var interval = Duration(seconds: _config.widgets.weather.fetchInterval);
    _timer = Timer.periodic(interval, (_) => _fetchForecast());
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
      var lat = _config.widgets.weather.lat;
      var lon = _config.widgets.weather.lon;
      http.get(
          Uri.parse(
              'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=$lat&lon=$lon'),
          headers: {
            'User-Agent': _config.widgets.weather.userAgent,
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
