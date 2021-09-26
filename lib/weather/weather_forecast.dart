import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'weather_provider.dart';
import 'weather_images.dart';
import 'date_util.dart';
import 'model/location_forecast.dart';

class WeatherForecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<Weather>(builder: _builder);

  Widget _builder(BuildContext context, Weather weather, _) {
    DateTime today = DateTime.now().stripTime();
    return Column(children: [
      Container(height: 72, child: DayForecast(date: today, weather: weather)),
      Container(height: 72, child: DayForecast(date: today.addDays(1), weather: weather)),
      Container(height: 72, child: DayForecast(date: today.addDays(2), weather: weather)),
    ],);
  }
}

class DayForecast extends StatelessWidget {
  final DateTime date;
  final Weather weather;
  final _style = TextStyle(fontSize: 24);

  DayForecast({required this.date, required this.weather});

  @override
  Widget build(BuildContext context) {
    var night = weather.forecast?.at(date.addHours(4));
    var morning = weather.forecast?.at(date.addHours(8));
    var afternoon = weather.forecast?.at(date.addHours(14));
    var evening = weather.forecast?.at(date.addHours(20));

    var nightTemp = night?.data.instant.details?.air_temperature?.round() ?? 0;
    var dayTemp = afternoon?.data.instant.details?.air_temperature?.round() ?? 0;
    
    var weekday = DateFormat('E').format(date);
    return Row(
      children: [
        SizedBox(width: 60, child: Text("$weekday", style: _style,)),
        _getImage(morning),
        _getImage(afternoon),
        _getImage(evening),
        SizedBox(width: 24),
        Text("$dayTemp℃ ($nightTemp℃)", style: _style)
      ],
    );
  }

  Widget _getImage(Forecast? forecast) {
    if (forecast != null && forecast.time.isAfter(DateTime.now())) {
      return SizedBox(
        width: 80, 
        child: Image.asset(WeatherImages.forecastImage(forecast)));
    }
    return SizedBox(width: 80);
  }
}
