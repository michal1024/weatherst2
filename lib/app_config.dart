import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

class App {
  bool debug;
  App(dynamic config)
    : debug = config['debug'] ?? false;
}
class Widgets {
  Weather weather;

  Widgets(dynamic config)
      : weather = Weather(config['weather']);
}

class Weather {
  double lon;
  double lat;
  String userAgent;
  int fetchInterval;

  Weather(dynamic config)
      : lon = config['lon'] ?? 0,
        lat = config['lat'] ?? 0,
        userAgent = config['user_agent'] ?? '',
        fetchInterval = config['fetch_interval'] ?? 3600;
}

class AppConfig {
  App app;
  Widgets widgets;

  AppConfig(dynamic config) :
    app = App(config['app']),
    widgets = Widgets(config['widgets']);

  static Future<AppConfig> fromYaml(String path) async {
    var yamlString = await rootBundle.loadString(path);
    var yaml = loadYaml(yamlString);
    return AppConfig(yaml);
  }
}
