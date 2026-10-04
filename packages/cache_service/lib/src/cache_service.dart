import 'dart:async';

import 'cache_data.dart';

abstract base class CacheService {
  FutureOr<void> init();

  FutureOr<CacheData?> get(String key);

  FutureOr<void> set(String key, CacheData data);

  FutureOr<void> remove(String key);

  FutureOr<void> clear();

  FutureOr<void> close();
}
