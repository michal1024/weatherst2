extension DateUtil on DateTime {
  DateTime stripTime() => DateTime(year, month, day);

  DateTime addDays(int days) => add(Duration(days: days));

  DateTime addHours(int hours) => add(Duration(hours: hours));
}