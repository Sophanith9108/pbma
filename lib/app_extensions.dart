import 'package:intl/intl.dart';

extension DateTimeFormatExtension on DateTime {
  String format({String pattern = 'dd.MMM.yyyy hh:mm:ss a'}) {
    return DateFormat(pattern).format(this);
  }
}
