// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:cache_service/cache_service.dart' as _i938;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:money_invest_app/src/core/core.dart' as _i902;
import 'package:money_invest_app/src/core/core_dependency.dart' as _i490;
import 'package:money_invest_app/src/data/data.dart' as _i306;
import 'package:money_invest_app/src/data/data_dependency.dart' as _i565;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initializeDependencies(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final coreDependency = _$CoreDependency();
  final dataDependency = _$DataDependency();
  gh.singleton<_i902.AppEnvironment>(() => coreDependency.getEnvironment());
  gh.singleton<_i902.HydratedCacheStorage>(
    () => coreDependency.getHydratedCacheStorage(),
  );
  await gh.lazySingletonAsync<_i306.LocalStorageService>(
    () => dataDependency.providesLocalStorageService(),
    preResolve: true,
  );
  await gh.lazySingletonAsync<_i938.CacheService>(
    () => dataDependency.providesCacheService(),
    preResolve: true,
  );
  gh.lazySingleton<_i306.FirebaseService>(
    () => dataDependency.providesFirebaseService(),
  );
  gh.lazySingleton<_i306.ApiClientService>(
    () => dataDependency.providesApiClientService(
      gh<_i902.AppEnvironment>(),
      gh<_i306.LocalStorageService>(),
    ),
  );
  gh.lazySingleton<_i306.SocketClientService>(
    () =>
        dataDependency.providesSocketClientService(gh<_i902.AppEnvironment>()),
  );
  return getIt;
}

class _$CoreDependency extends _i490.CoreDependency {}

class _$DataDependency extends _i565.DataDependency {}
