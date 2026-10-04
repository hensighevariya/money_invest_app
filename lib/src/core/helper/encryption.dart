import 'dart:convert';

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
  late final IV _iv;
  late final Encrypter _encrypter;
  late final Hmac _hMac;

  AesEncryption.fromUtf8({required String key, required String iv}) {
    var encryptionKey = Key.fromUtf8(key);
    _iv = IV.fromUtf8(iv);
    _encrypter = Encrypter(AES(encryptionKey, mode: AESMode.cbc));
    _hMac = Hmac(sha256, encryptionKey.bytes);
  }

  AesEncryption.fromBase64({required String key, required String iv}) {
    var encryptionKey = Key.fromBase64(key);
    _iv = IV.fromBase64(iv);
    _encrypter = Encrypter(AES(encryptionKey, mode: AESMode.cbc));
    _hMac = Hmac(sha256, encryptionKey.bytes);
  }

  CipherData encrypt(String plainText) {
    try {
      var encryptedValue = _encrypter.encrypt(plainText, iv: _iv).base64.replaceAll('\n', '');
      var mac = _createMac(encryptedValue);
      return CipherData(mac: mac.toString(), value: encryptedValue);
    } catch (e) {
      rethrow;
    }
  }

  String decrypt(CipherData data) {
    var valueMac = _createMac(data.value);
    if (valueMac.toString() == data.mac) {
      return _encrypter.decrypt64(data.value, iv: _iv);
    } else {
      throw const InvalidMacException();
    }
  }

  String _createMac(String value) {
    return _hMac.convert(utf8.encode(_iv.base64 + value)).toString();
  }
}

class InvalidMacException implements Exception {
  const InvalidMacException();
}

Error error = Error();
