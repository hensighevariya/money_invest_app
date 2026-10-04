import 'dart:convert';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

class CipherData {
  String mac;
  String value;

  CipherData({required this.mac, required this.value});

  factory CipherData.fromJson(Map<String, dynamic> json) {
    return CipherData(mac: json['mac'].toString(), value: json['value'].toString());
  }

  Map<String, dynamic> toJson() {
    return {'mac': mac, 'value': value};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is CipherData && other.mac == mac && other.value == value);

  @override
  String toString() => 'CipherData(mac: $mac, value: $value)';

  @override
  int get hashCode => Object.hash(mac, value);
}

class AesEncryption {
  late final Encrypter _encrypter;
  late final Hmac _hMac;

  static const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890';

  AesEncryption.fromUtf8({required String key}) {
    var encryptionKey = Key.fromUtf8(key);
    _encrypter = Encrypter(AES(encryptionKey, mode: AESMode.cbc));
    _hMac = Hmac(sha256, encryptionKey.bytes);
  }

  AesEncryption.fromBase64({required String key}) {
    var encryptionKey = Key.fromBase64(key);
    _encrypter = Encrypter(AES(encryptionKey, mode: AESMode.cbc));
    _hMac = Hmac(sha256, encryptionKey.bytes);
  }

  CipherData encrypt(String plainText) {
    final initialVector = _generateIV();
    final iv = IV.fromUtf8(initialVector);
    var encryptedValue = _encrypter.encrypt(plainText, iv: iv).base64.replaceAll('\n', '');
    var mac = _hMac.convert(utf8.encode(iv.base64 + encryptedValue));
    var encData = CipherData(mac: mac.toString(), value: initialVector + encryptedValue);
    return encData;
  }

  String decrypt(CipherData cipher) {
    final iv = IV.fromUtf8(cipher.value.substring(0, 16));
    final data = cipher.value.substring(16);
    var mac = _hMac.convert(utf8.encode(iv.base64 + data));
    if (mac.toString() != cipher.mac) throw const InvalidMacException();
    return _encrypter.decrypt64(data, iv: iv);
  }

  static String generateKey([int keyLength = 32]) {
    final random = math.Random.secure();

    return List.generate(keyLength, (index) => _chars[(random.nextDouble() * _chars.length).floor()]).join();
  }

  String _generateIV([int length = 16]) {
    final random = math.Random.secure();

    return List.generate(length, (index) => _chars[(random.nextDouble() * _chars.length).floor()]).join();
  }
}

class InvalidMacException implements Exception {
  const InvalidMacException();
}

Error error = Error();
