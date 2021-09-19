import 'package:weatherst2/weather/model/location_forecast.dart';

class WeatherImages {
  static String forecastImage(Forecast? forecast) {
    String symbol =
        forecast?.data.next.summary?.symbol_code ?? 'partlycloudy_day';
    return 'images/weathericon/$symbol.png';
  }
}
