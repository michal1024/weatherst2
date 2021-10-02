import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

class Widgets {
  Weather weather;
  Network network;

  Widgets(Map<String, String> config)
      : weather = Weather(config),
        network = Network();
}

class Weather {
  double lon;
  double lat;
  String userAgent;

  Weather(Map<String, String> config)
      : lon = double.parse(config['lon'] ?? '0'),
        lat = double.parse(config['lat'] ?? '0'),
        userAgent = config['user_agent'] ?? '';
}

class Network {}

class AppConfig {
  Widgets widgets = Widgets(Map<String, String>());

  static Future<AppConfig> fromYaml(String path,
      {Map<String, String>? mergeWith}) async {
    var configYaml = await rootBundle.loadString(path);
    var config = loadYaml(configYaml);
    return AppConfig();
  }
}
