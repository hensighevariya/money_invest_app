import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String {
  DateTime parseUtcDateTime([String format = 'yyyy-MM-dd HH:mm:ss']) {
    var time = DateFormat(format).parseUTC(replaceAll('T', ' ').replaceAll('Z', ' '));
    return time;
  }

  DateTime parseLocalDateTime([String format = 'yyyy-MM-dd HH:mm:ss']) {
    var time = DateFormat(format).parse(replaceAll('T', ' ').replaceAll('Z', ' '));
    return time;
  }

  String obscureEmail([int? length = 3]) {
    if (isEmpty) return this;
    var parts = split('@');
    if (parts.first.length > 3) {
      return "${parts.first.substring(0, length).padRight(parts.first.length, '*')}@${parts.last}";
    }
    return this;
  }

  String obscureMobileNumber() {
    if (isEmpty) return this;
    if (length > 6) {
      return substring(0, 3).padRight(length - 3, '*') + substring(length - 3, length);
    }
    return this;
  }

  String formatMobileNumber([String format = '### ### ####']) {
    Characters formatCharacters = format.characters;
    Characters numberCharacters = replaceAll(RegExp(r'[^0-9]'), '').characters;

    StringBuffer buffer = StringBuffer();
    int skipNumberCharacter = 0;
    for (final String character in formatCharacters) {
      if (character == '#') {
        final String numberCharacter = numberCharacters.skip(skipNumberCharacter).take(1).first;
        buffer.write(numberCharacter);
        skipNumberCharacter++;
      } else {
        buffer.write(character);
      }
      if (skipNumberCharacter == numberCharacters.length) break;
    }

    if (skipNumberCharacter != numberCharacters.length) {
      final remainingCharacter = numberCharacters.skip(skipNumberCharacter);
      for (final String character in remainingCharacter) {
        buffer.write(character);
      }
    }
    return buffer.toString().trim();
  }

  String get capitalize {
    if (length <= 1) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension NullableStringExtensions on String? {
  bool get isNullOrEmpty => this?.trim().isEmpty ?? true;

  int toInt() {
    return this == null ? 0 : int.tryParse(this!) ?? 0;
  }

  double toDouble() {
    return this == null ? 0 : double.tryParse(this?.replaceAll(RegExp(r'[^0-9.]'), '') ?? '0') ?? 0.0;
  }
}
