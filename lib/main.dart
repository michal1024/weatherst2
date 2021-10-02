import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherst2/weather/weather_forecast.dart';
import 'package:weatherst2/clock/clock.dart';
import 'package:weatherst2/weather/current_weather.dart';
import 'package:weatherst2/weather/weather_provider.dart';
import 'package:weatherst2/network/network_stats.dart';

import 'app_config.dart' as config;

Future main() async {
  var config = await loadConfig();
  runApp(MyApp(config));
}

Future<config.AppConfig> loadConfig() async {
  await dotenv.load(fileName: '.env', mergeWith: Platform.environment);
  return config.AppConfig.fromYaml('config.yaml', mergeWith: dotenv.env);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final config.AppConfig appConfig;

  MyApp(this.appConfig);

  @override
  Widget build(BuildContext context) {
    return Provider<config.AppConfig>.value(
        value: appConfig,
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(brightness: Brightness.dark),
            home: HomeView()));
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: WidgetsView(),
        ));
  }
}

class WidgetsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProxyProvider<config.AppConfig, Weather>(
              create: (_) => Weather(), update: (_, config, __) => Weather())
        ],
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: Clock()),
                Expanded(child: CurrentWeather()),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(child: NetworkStats(), width: 500, height: 200),
                WeatherForecast()
              ])
        ]));
  }
}
