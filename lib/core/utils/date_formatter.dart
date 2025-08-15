import 'package:intl/intl.dart';

class AppDateFormatter {
  static final DateFormat mmddyyyy = DateFormat('MM.dd.yyyy');

  static String formatMmDdYyyy(DateTime? date) {
    if (date == null) return '';
    return mmddyyyy.format(date);
  }
}
