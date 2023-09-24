import 'package:intl/intl.dart';

DateTime stringToDateAndTimeZone(String date) {
  return DateFormat('yyyy-MM-dd hh:mm:ss.SSS').parseUtc(date);
}

String dateTimeToStringWithZone(DateTime date) {
  return date.toUtc().toIso8601String().replaceFirst('T', ' ');
}
