import 'package:flutter/services.dart';

abstract interface class NativeMethodChannel {
  static const methodChannel = MethodChannel('app.native_method_channel');
}
