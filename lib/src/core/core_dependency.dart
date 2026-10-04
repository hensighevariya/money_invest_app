import 'package:injectable/injectable.dart';
import 'package:money_invest_app/src/core/core.dart';

@module
abstract class CoreDependency {
  @singleton
  AppEnvironment getEnvironment() {
    return AppEnvironment.fromDartEnvironment();
  }

  @singleton
  HydratedCacheStorage getHydratedCacheStorage() {
    return HydratedCacheStorage();
  }
}
