import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'weather_provider.dart';

class Forecast extends StatelessWidget {
  const Forecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<Weather>(builder: _builder);

  Widget _builder(BuildContext context, Weather weather, _) {
    return Text("Forecast goes here");
  }
}
