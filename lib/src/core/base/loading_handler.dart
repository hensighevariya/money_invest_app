import 'package:flutter/foundation.dart';

abstract mixin class LoadingHandler {
  const LoadingHandler();

  @mustCallSuper
  void startLoading() {
    handleLoading(true);
  }

  @mustCallSuper
  void stopLoading() {
    handleLoading(false);
  }

  void handleLoading(bool loading);
}