import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:money_invest_app/src/app/app.dart';
import '../localization/localization.dart';
import '../presentation/presentation.dart';
import 'routes/routes.dart';

class MoneyInvestApp extends StatefulWidget {
  const MoneyInvestApp({super.key});

  static MoneyInvestAppState of(BuildContext context) {
    final state = context.findAncestorStateOfType<MoneyInvestAppState>();
    assert(state != null, 'No SecuritySaasApp found in context!');
    return state!;
  }

  @override
  State<MoneyInvestApp> createState() => MoneyInvestAppState();
}

class MoneyInvestAppState extends State<MoneyInvestApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final RouteObserver routeObserver = RouteObserver();
  late final AppRoutes _appRouteGenerator;

  @override
  void initState() {
    super.initState();
    Bloc.observer = AppBlocObserver(navigatorKey);

    final userProfileState = context.read<UserProfileBloc>().state;
    _appRouteGenerator = AppRoutes(navigatorKey: navigatorKey, userAuthorized: userProfileState.isUserAuthorized);

    if(userProfileState.isUserAuthorized) {
      context.read<UserProfileBloc>().add(const FetchUserProfile());
    }
  }

  void _onUserAuthorizedStatusChanged(BuildContext context, UserProfileState state) {
    _appRouteGenerator.userAuthorized = state.isUserAuthorized;
  }

  @override
  Widget build(BuildContext context) {
    final language = context.select<LocalizationBloc, Language>((value) => value.state.selectedLanguage);
    final themes = SecuritySaasAppTheme(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<UserProfileBloc, UserProfileState>(
          listenWhen: (previous, current) => previous.isUserAuthorized != current.isUserAuthorized,
          listener: _onUserAuthorizedStatusChanged,
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        restorationScopeId: 'money_invest_app',
        onGenerateTitle: (context) => AppLocalizations.of(context).appName,
        themeMode: ThemeMode.light,
        theme: themes.lightTheme,
        locale: Locale(language.languageCode),
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        routerConfig: _appRouteGenerator.routerConfig,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      ),
    );
  }
}
