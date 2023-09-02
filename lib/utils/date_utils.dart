import 'package:intl/intl.dart';

class DateUtil {
  static String formatDate(DateTime dateTime, String locale) {
    final formatter = DateFormat('dd MMM HH:mm', locale);
    return formatter.format(dateTime).toUpperCase();
  }
}