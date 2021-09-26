import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherst2/weather/weather_forecast.dart';
import 'clock/clock.dart';
import 'weather/current_weather.dart';
import 'weather/weather_forecast.dart';
import 'weather/weather_provider.dart';
import 'network/network_stats.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: HomeView()
    );
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: WidgetsView(),
      )
    );
  }
}

class WidgetsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Weather())
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
            WeatherForecast()]
        )]
      )
    );
  }
}
