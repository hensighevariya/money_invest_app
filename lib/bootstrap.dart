import 'dart:async';

import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:money_invest_app/src/localization/localization.dart';

import 'src/core/core.dart';
import 'src/data/data.dart';
import 'src/presentation/presentation.dart';
import 'src/utils/log.dart';

typedef AsyncAppBuilder = FutureOr<Widget> Function();

Future<void> bootstrap(AsyncAppBuilder builder) async {
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final dependencyHelper = DependencyHelper.instance;
      await dependencyHelper.initialize();
      await _configureHydratedBloc();
      _configureSystemUi().ignore();

      final app = await builder();
      runApp(
        AdaptiveLayout.fromView(
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider(
                create: (context) {
                  return AuthRepository(
                    localStorageService: dependencyHelper.get(),
                    apiClientService: dependencyHelper.get(),
                    firebaseService: dependencyHelper.get(),
                    environment: dependencyHelper.get(),
                  );
                },
                dispose: (value) => value.dispose(),
              ),
              RepositoryProvider(
                create: (context) {
                  return UserRepository(
                    localStorageService: dependencyHelper.get(),
                    apiClientService: dependencyHelper.get(),
                    firebaseService: dependencyHelper.get(),
                  );
                },
                dispose: (value) => value.dispose(),
              ),
              RepositoryProvider(
                create: (context) {
                  return CommonRepository(
                    localStorageService: dependencyHelper.get(),
                    apiClientService: dependencyHelper.get(),
                    firebaseService: dependencyHelper.get(),
                    environment: dependencyHelper.get(),
                  );
                },
                dispose: (value) => value.dispose(),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) {
                    return LocalizationBloc.fromSystem(
                      localizationsDelegate: AppLocalizations.delegate,
                      commonRepository: RepositoryProvider.of(context),
                    );
                  },
                ),
                BlocProvider(
                  create: (context) {
                    return AppVersionBloc(commonRepository: RepositoryProvider.of(context));
                  },
                ),
                BlocProvider(
                  create: (context) {
                    return NotificationBloc(commonRepository: RepositoryProvider.of(context));
                  },
                ),
                BlocProvider(
                  create: (context) => UserProfileBloc(
                    userRepository: RepositoryProvider.of(context),
                    localStorageService: DependencyHelper.instance.get(),
                  )..add(const GetCurrentUser()),
                ),
                BlocProvider(
                  create: (context) {
                    return MainNavigationBloc();
                  },
                ),
              ],
              child: app,
            ),
          ),
        ),
      );
    },
    (error, stackTrace) {
      Log.debug(error);
      Log.debug(stackTrace);
    },
  );
}

Future<void> _configureSystemUi() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemStatusBarContrastEnforced: false,
    ),
  );
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

Future<void> _configureHydratedBloc() async {
  final temporaryDirectory = await getTemporaryDirectory();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(temporaryDirectory.path),
  );
}
