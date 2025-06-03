import 'dart:convert';

import 'package:crypto/crypto.dart';
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

extension ColorGradientExtension on Color {
  Gradient get lightToDarkGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [withValues(alpha: .5), withValues(alpha: 1.0)],
  );

  Gradient get leftToRightGradient => LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [withValues(alpha: .5), withValues(alpha: 1.0)],
  );

  Gradient get radialGradient => RadialGradient(
    center: Alignment.center,
    radius: 0.7,
    colors: [withValues(alpha: .5), withValues(alpha: 1.0)],
  );

  Gradient get sweepGradient => SweepGradient(
    colors: [
      withValues(alpha: 1.0),
      withValues(alpha: 0.8),
      withValues(alpha: .6),
      withValues(alpha: .4),
      withValues(alpha: .2),
      withValues(alpha: .4),
      withValues(alpha: .6),
      withValues(alpha: .8),
    ],
    startAngle: 0.0,
    endAngle: 2 * 3.1416, // full circle
  );
}

extension NumberFormatExtension on num {
  String formatCurrency({
    String symbol = '',
    String sign = '',
    String pattern = '#,##0.###',
    int decimalDigits = 2,
  }) => '$sign${NumberFormat(pattern, 'en_US').format(this)}$symbol';
}

extension StringExtension on String {
  String hashPassword() {
    var bytes = utf8.encode(this);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}

extension StringFirstLastExtenstion on String {
  String get firstAndLastLetters =>
      '${substring(0, 1)}${substring(length - 1)}';
}
