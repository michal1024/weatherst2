import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

class Widgets {
  Weather weather;
  Network network;

  Widgets(dynamic config)
      : weather = Weather(config['weather']),
        network = Network(config['network']);
}

class Weather {
  double lon;
  double lat;
  String userAgent;

  Weather(dynamic config)
      : lon = config['lon'] ?? 0,
        lat = config['lat'] ?? 0,
        userAgent = config['user_agent'] ?? '';
}

class Network {
  String apiKey;

  Network(dynamic config)
    : apiKey = config['api_key'];
}

class AppConfig {
  Widgets widgets;

  AppConfig(dynamic config) :
    widgets = Widgets(config['widgets']);

  static Future<AppConfig> fromYaml(String path) async {
    var yamlString = await rootBundle.loadString(path);
    var yaml = loadYaml(yamlString);
    return AppConfig(yaml);
  }
}
