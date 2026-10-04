import 'package:hydrated_bloc/hydrated_bloc.dart';

class HydratedCacheStorage extends Storage {
  final Map<String, dynamic> _cache = {};

  @override
  Future<void> clear() {
    _cache.clear();
    return Future.value();
  }

  @override
  Future<void> close() {
    _cache.clear();
    return Future.value();
  }

  @override
  Future<void> delete(String key) {
    _cache.clear();
    return Future.value();
  }

  @override
  dynamic read(String key) {
    return _cache[key];
  }

  @override
  Future<void> write(String key, dynamic value) {
    _cache[key] = value;
    return Future.value();
  }
}
