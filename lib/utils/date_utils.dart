import 'package:intl/intl.dart';

class DateUtil {
  static String formatDate(DateTime dateTime, String locale) {
    final formatter = DateFormat('dd MMM HH:mm', locale);
    return formatter.format(dateTime).toUpperCase();
  }

  static String formatBirthdate(DateTime dateTime, String locale) {
    final formatter = DateFormat('dd MMM', locale);
    return formatter.format(dateTime).toUpperCase();
  }

  static String formatBirthdate2(DateTime? dateTime, String locale) {
    if (dateTime == null) return '';
    final formatter = DateFormat('dd MMM yyyy', locale);
    return formatter.format(dateTime).toUpperCase();
  }

  static String getHour(DateTime? dateTime, String locale) {
    if (dateTime == null) return '';
    final formatter = DateFormat('h:mm a', locale);
    String formattedTime = formatter.format(dateTime);

    // Replace "P.M." with "PM" and "A.M." with "AM"
    formattedTime =
        formattedTime.replaceAll('.', '').toUpperCase();
    return formattedTime;
  }

  static String formatDayAbbreviation(DateTime dateTime, String locale) {
    // Set the locale
    Intl.defaultLocale = locale;
    // Create a date format for the day of the week abbreviation, e.g., "Mon", "Tue", etc.
    final formatter = DateFormat.E(locale);
    // Format the date and return the uppercased abbreviation
    return formatter.format(dateTime).toUpperCase();
  }
}
