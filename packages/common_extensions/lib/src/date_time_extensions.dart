import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toLocalString([String format = 'yyyy-MM-dd HH:mm:ss']) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toUtcString([String format = 'yyyy-MM-dd HH:mm:ss']) {
    var strDate = DateFormat(format).format(toUtc());
    return strDate;
  }

  bool get isToday {
    var now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }

  bool isSameDay(DateTime dateTime) {
    return day == dateTime.day && month == dateTime.month && year == dateTime.year;
  }

  DateTime toDate() {
    return DateTime(year, month, day);
  }
}
