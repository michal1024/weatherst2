import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weatherst2/weather/weather_forecast.dart';
import 'package:weatherst2/clock/clock.dart';
import 'package:weatherst2/weather/current_weather.dart';
import 'package:weatherst2/weather/weather_provider.dart';
//import 'package:weatherst2/network/network_stats.dart';
import 'package:window_manager/window_manager.dart';

import 'app_config.dart' show AppConfig;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var config = await loadConfig();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    if (!config.app.debug) {
      await windowManager.setAsFrameless();
      await windowManager.setSize(Size(800, 480));
      await windowManager.setPosition(Offset.zero);
    }
    windowManager.show();
  });
  runApp(MyApp(config));
}

Future<AppConfig> loadConfig() async {
  return AppConfig.fromYaml('config.yaml');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AppConfig appConfig;

  MyApp(this.appConfig);

  @override
  Widget build(BuildContext context) {
    return Provider<AppConfig>.value(
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
          ChangeNotifierProxyProvider<AppConfig, Weather>(
              create: (_) => Weather(Provider.of<AppConfig>(context, listen: false)), 
              update: (_, config, __) => Weather(config))
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
                //SizedBox(child: NetworkStats(), width: 500, height: 200),
                WeatherForecast()
              ])
        ]));
  }
}
