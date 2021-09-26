
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class NetworkStats extends StatelessWidget {
  final List<double> yValues = [3, 1, 8, 5, 2, 8, 3];

  @override
  Widget build(BuildContext context) {
    int i =0;
    return BarChart(
      BarChartData(
        maxY: 10,
        minY: 0,
        barGroups: yValues.map((e) => BarChartGroupData(
          x: ++i,
          barRods: [BarChartRodData(y: e)]
        )).toList()
      )
    );
  }
}