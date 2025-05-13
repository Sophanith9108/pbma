import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeFormatExtension on DateTime {
  String format({String pattern = 'dd.MMM.yyyy hh:mm:ss a'}) {
    return DateFormat(pattern).format(this);
  }
}

extension TimeOfDayFormatExtension on TimeOfDay {
  String toTimeOfDay({String pattern = 'hh:mm a'}) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, hour, minute);
    return DateFormat(pattern).format(dateTime);
  }
}
