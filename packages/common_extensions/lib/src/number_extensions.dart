import 'package:intl/intl.dart';

extension NumberExtensions on num? {
  String formattedAmount([int? decimalDigits]) {
    final NumberFormat numberFormat = NumberFormat.currency(
      locale: 'en',
      customPattern: '##,###.##',
      decimalDigits: decimalDigits ?? 2,
    );
    final String amountString = numberFormat.format(this ?? 0);
    return amountString;
  }
}
