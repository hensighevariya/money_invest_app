enum EnvironmentType {
  development,
  production;

  bool get isDevelopment => this == EnvironmentType.development;
  bool get isProduction => this == EnvironmentType.production;
}

class AppEnvironment {
  const AppEnvironment({
    this.environmentType = EnvironmentType.development,
    required this.baseUrl,
    required this.apiBaseUrl,
    required this.tradeUrl,
    required this.socketUrl,
    required this.apiEncryptionKey,
    required this.apiDecryptionKey,
    required this.googleServerClientId,
    required this.apiEncryptionIvKey,
    required this.apiDecryptionIvKey,
    required this.bucketName,
    required this.region,
  });

  static AppEnvironment? _current;
  static AppEnvironment get current =>
      _current ??= AppEnvironment.fromDartEnvironment();
  static set current(AppEnvironment env) => _current = env;

  factory AppEnvironment.development({
    String baseUrl =
        'https://7d9c-2402-a00-162-20fd-e8a0-fd73-9997-32b.ngrok-free.app/',
    String? apiBaseUrl,
    String? tradeUrl,
    String? socketUrl,
    String apiEncryptionKey = '',
    String apiDecryptionKey = '',
    String googleServerClientId = '',
    String apiEncryptionIvKey = '',
    String apiDecryptionIvKey = '',
    String bucketName = '',
    String region = '',
  }) {
    final base = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
    return AppEnvironment(
      environmentType: EnvironmentType.development,
      baseUrl: base,
      apiBaseUrl: apiBaseUrl ?? base,
      tradeUrl: tradeUrl ?? base,
      socketUrl: socketUrl ?? base,
      apiEncryptionKey: apiEncryptionKey,
      apiDecryptionKey: apiDecryptionKey,
      googleServerClientId: googleServerClientId,
      apiEncryptionIvKey: apiEncryptionIvKey,
      apiDecryptionIvKey: apiDecryptionIvKey,
      bucketName: bucketName,
      region: region,
    );
  }

  factory AppEnvironment.production({
    String baseUrl = 'https://api.moneyinvest.com/',
    String? apiBaseUrl,
    String? tradeUrl,
    String? socketUrl,
    String apiEncryptionKey = '',
    String apiDecryptionKey = '',
    String googleServerClientId = '',
    String apiEncryptionIvKey = '',
    String apiDecryptionIvKey = '',
    String bucketName = '',
    String region = '',
  }) {
    final base = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
    return AppEnvironment(
      environmentType: EnvironmentType.production,
      baseUrl: base,
      apiBaseUrl: apiBaseUrl ?? base,
      tradeUrl: tradeUrl ?? base,
      socketUrl: socketUrl ?? base,
      apiEncryptionKey: apiEncryptionKey,
      apiDecryptionKey: apiDecryptionKey,
      googleServerClientId: googleServerClientId,
      apiEncryptionIvKey: apiEncryptionIvKey,
      apiDecryptionIvKey: apiDecryptionIvKey,
      bucketName: bucketName,
      region: region,
    );
  }

  factory AppEnvironment.fromDartEnvironment() {
    final envName = const String.fromEnvironment(
      'env.name',
      defaultValue: 'development',
    ).toLowerCase();
    final isProd = envName == 'production' || envName == 'prod';

    final defaultBase = isProd
        ? 'https://api.moneyinvest.com/'
        : 'https://7d9c-2402-a00-162-20fd-e8a0-fd73-9997-32b.ngrok-free.app/';

    final rawBaseUrl = const String.fromEnvironment('env.baseUrl');
    final baseUrl = rawBaseUrl.isNotEmpty ? rawBaseUrl : defaultBase;

    final rawApiBaseUrl = const String.fromEnvironment('env.apiBaseUrl');
    final apiBaseUrl = rawApiBaseUrl.isNotEmpty ? rawApiBaseUrl : baseUrl;

    final rawTradeUrl = const String.fromEnvironment('env.tradeUrl');
    final tradeUrl = rawTradeUrl.isNotEmpty ? rawTradeUrl : baseUrl;

    final rawSocketUrl = const String.fromEnvironment('env.socketUrl');
    final socketUrl = rawSocketUrl.isNotEmpty ? rawSocketUrl : baseUrl;

    return AppEnvironment(
      environmentType:
          isProd ? EnvironmentType.production : EnvironmentType.development,
      baseUrl: baseUrl.endsWith('/') ? baseUrl : '$baseUrl/',
      apiBaseUrl: apiBaseUrl.endsWith('/') ? apiBaseUrl : '$apiBaseUrl/',
      tradeUrl: tradeUrl.endsWith('/') ? tradeUrl : '$tradeUrl/',
      socketUrl: socketUrl,
      apiEncryptionKey: const String.fromEnvironment('env.apiEncryptionKey'),
      apiDecryptionKey: const String.fromEnvironment('env.apiDecryptionKey'),
      googleServerClientId: const String.fromEnvironment(
        'env.googleServerClientId',
      ),
      apiEncryptionIvKey: const String.fromEnvironment(
        'env.apiEncryptionIvKey',
      ),
      apiDecryptionIvKey: const String.fromEnvironment(
        'env.apiDecryptionIvKey',
      ),
      bucketName: const String.fromEnvironment('env.bucketName'),
      region: const String.fromEnvironment('env.region'),
    );
  }

  final EnvironmentType environmentType;
  final String baseUrl;
  final String apiBaseUrl;
  final String tradeUrl;
  final String socketUrl;
  final String apiEncryptionKey;
  final String apiDecryptionKey;
  final String apiEncryptionIvKey;
  final String apiDecryptionIvKey;
  final String googleServerClientId;
  final String bucketName;
  final String region;

  bool get isDevelopment => environmentType.isDevelopment;
  bool get isProduction => environmentType.isProduction;

  String get imageBaseUrl => awsImageUrl;

  String get awsImageUrl => 'https://$bucketName.s3.$region.amazonaws.com/';
}
