import 'dart:async';

import 'cache_data.dart';
import 'cache_service.dart';

final class MemoryCacheService extends CacheService {
  MemoryCacheService();

  final Map<String, dynamic> _cache = {};

  @override
  FutureOr<void> init() {}

  @override
  FutureOr<CacheData?> get(String key) {
    final value = _cache[key];
    return value != null
        ? CacheData.fromJson(value as Map<String, dynamic>)
        : null;
  }

  @override
  FutureOr<void> set(String key, CacheData data) {
    _cache[key] = data.toJson();
  }

  @override
  FutureOr<void> remove(String key) {
    _cache.remove(key);
  }

  @override
  FutureOr<void> clear() {
    _cache.clear();
  }

  @override
  FutureOr<void> close() {
    _cache.clear();
  }
}
