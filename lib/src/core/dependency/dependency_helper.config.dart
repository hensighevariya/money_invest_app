// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cache_service/cache_service.dart' as _i938;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:money_invest_app/src/core/core.dart' as _i142;
import 'package:money_invest_app/src/core/core_dependency.dart' as _i618;
import 'package:money_invest_app/src/data/data.dart' as _i916;
import 'package:money_invest_app/src/data/data_dependency.dart' as _i622;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initializeDependencies(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final coreDependency = _$CoreDependency();
  final dataDependency = _$DataDependency();
  gh.singleton<_i142.AppEnvironment>(() => coreDependency.getEnvironment());
  gh.singleton<_i142.HydratedCacheStorage>(
    () => coreDependency.getHydratedCacheStorage(),
  );
  await gh.lazySingletonAsync<_i916.LocalStorageService>(
    () => dataDependency.providesLocalStorageService(),
    preResolve: true,
  );
  await gh.lazySingletonAsync<_i938.CacheService>(
    () => dataDependency.providesCacheService(),
    preResolve: true,
  );
  gh.lazySingleton<_i916.FirebaseService>(
    () => dataDependency.providesFirebaseService(),
  );
  gh.lazySingleton<_i916.ApiClientService>(
    () => dataDependency.providesApiClientService(
      gh<_i142.AppEnvironment>(),
      gh<_i916.LocalStorageService>(),
    ),
  );
  gh.factory<_i916.SocketClientService>(
    () =>
        dataDependency.providesSocketClientService(gh<_i142.AppEnvironment>()),
  );
  return getIt;
}

class _$CoreDependency extends _i618.CoreDependency {}

class _$DataDependency extends _i622.DataDependency {}
