import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow input to be empty
    if (newValue.text.isEmpty) return newValue;

    // Remove non-numeric characters (so only numbers remain)
    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limit input to 8 digits (for ddMMyyyy format)
    if (text.length > 8) {
      text = text.substring(0, 8);
    }

    String datePart = text.substring(0, text.length > 2 ? 2 : null);
    String monthPart = text.length >= 3 ? text.substring(2, text.length > 4 ? 4 : null) : '';
    String yearPart = text.length > 4 ? text.substring(4) : '';

    if (datePart.isNotEmpty && datePart.toInt() > 31) {
      datePart = '01';
    }
    if (monthPart.isNotEmpty && monthPart.toInt() > 12) {
      monthPart = '01';
    }

    final value = [
      if (datePart.isNotEmpty) datePart,
      if (monthPart.isNotEmpty) monthPart,
      if (yearPart.isNotEmpty) yearPart,
    ].join('/');

    return newValue.copyWith(text: value, selection: TextSelection.collapsed(offset: value.length));
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  static const _separator = ' ';

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text.replaceAll(' ', '').trim();
    if (newValue.text.length < oldValue.text.length) {
      var text = newValue.text.trim();
      return newValue.copyWith(text: text, selection: TextSelection.collapsed(offset: text.length));
    } else if (newText.isNotEmpty && int.tryParse(newValue.text.split(' ').last) == null) {
      return oldValue;
    } else if (newText.length < 4) {
      return newValue;
    } else if (newText.length > 16) {
      return oldValue;
    }
    var string = _getFormattedCardNumber(newText);
    return newValue.copyWith(text: string, selection: TextSelection.collapsed(offset: string.length));
  }

  String _getFormattedCardNumber(String cardNumber) {
    var buffer = StringBuffer();
    for (int i = 0; i < cardNumber.length; i++) {
      buffer.write(cardNumber[i]);
      if ((i + 1) % 4 == 0) buffer.write(_separator);
    }
    return buffer.toString().trim();
  }
}

class CardExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow input to be empty
    if (newValue.text.isEmpty) return newValue;

    // Remove non-numeric characters (so only numbers remain)
    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limit input to 4 digits (for MM/YY format)
    if (text.length > 4) text = text.substring(0, 4);

    String monthPart = text.substring(0, text.length > 2 ? 2 : null);
    String yearPart = text.length > 2 ? text.substring(2) : '';
    if (monthPart.isNotEmpty && monthPart.toInt() > 12) {
      monthPart = '01';
    }

    final value = [if (monthPart.isNotEmpty) monthPart, if (yearPart.isNotEmpty) yearPart].join('/');

    return newValue.copyWith(text: value, selection: TextSelection.collapsed(offset: value.length));
  }
}
