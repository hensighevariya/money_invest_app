import 'package:cache_service/cache_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart' hide Environment;
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/network/interceptors.dart';

@module
abstract class DataDependency {
  @preResolve
  @lazySingleton
  Future<LocalStorageService> providesLocalStorageService() async {
    SharedPreferencesWithCache preferences = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
    return LocalStorageService(preferences);
  }

  @preResolve
  @lazySingleton
  Future<CacheService> providesCacheService() async {
    String? storagePath = await getTemporaryDirectory().then((value) => value.path);
    CacheService service = StorageCacheService(storagePath: storagePath, storageKey: 'security-saas-cache');
    return service..init();
  }

  @lazySingleton
  ApiClientService providesApiClientService(AppEnvironment environment, LocalStorageService localStorageService) {
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: environment.apiBaseUrl,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1),
      headers: {Headers.acceptHeader: Headers.jsonContentType, Headers.contentTypeHeader: Headers.jsonContentType},
    );

    final dioClient = Dio(baseOptions);
    final refreshDioClient = Dio(baseOptions);
    if (kDebugMode) {
      refreshDioClient.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }

    dioClient.interceptors.addAll([
      ApiInterceptor(
        logEnabled: kDebugMode,
        localStorageService: localStorageService,
        dioClient: refreshDioClient,
        encryptionKey: environment.apiEncryptionKey,
        decryptionKey: environment.apiDecryptionKey,
        encryptionIvKey: environment.apiEncryptionIvKey,
        decryptionIvKey: environment.apiDecryptionIvKey,
      ),
    ]);

    return ApiClientService(dioClient);
  }

  @lazySingleton
  FirebaseService providesFirebaseService() {
    return FirebaseService(/*options: DefaultFirebaseOptions.currentPlatform*/)..initialize();
  }

  @lazySingleton
  SocketClientService providesSocketClientService(AppEnvironment environment) {
    return SocketClientService(url: environment.socketUrl);
  }
}
