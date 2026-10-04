import 'dart:async';

import 'package:hive/hive.dart';
import 'package:synchronized/synchronized.dart';

import 'cache_data.dart';
import 'cache_service.dart';

final class StorageCacheService extends CacheService {
  StorageCacheService({this.storageKey, this.storagePath});

  final String? storageKey;
  final String? storagePath;
  final Completer<LazyBox<CacheData>> _hiveBoxCompleter = Completer();
  final _lock = Lock();

  @override
  FutureOr<void> init() async {
    Hive.registerAdapter(CacheDataAdapter());
    final hiveBox = await Hive.openLazyBox<CacheData>(storageKey ?? 'storage_cache_service', path: storagePath);
    _hiveBoxCompleter.complete(hiveBox);
  }

  @override
  Future<CacheData?> get(String key) async {
    final hiveBox = await _hiveBoxCompleter.future;
    return hiveBox.get(key);
  }

  @override
  Future<void> set(String key, CacheData data) async {
    final hiveBox = await _hiveBoxCompleter.future;
    await _lock.synchronized(() => hiveBox.put(key, data));
  }

  @override
  Future<void> remove(String key) async {
    final hiveBox = await _hiveBoxCompleter.future;
    await _lock.synchronized(() => hiveBox.delete(key));
  }

  @override
  Future<void> clear() async {
    final hiveBox = await _hiveBoxCompleter.future;
    await _lock.synchronized(() => hiveBox.clear());
  }

  @override
  Future<void> close() async {
    final hiveBox = await _hiveBoxCompleter.future;
    await _lock.synchronized(() => hiveBox.close());
  }
}
