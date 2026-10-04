class AppEnvironment {
  const AppEnvironment({
    required this.baseUrl,
    required this.apiBaseUrl,
    required this.socketUrl,
    required this.apiEncryptionKey,
    required this.apiDecryptionKey,
    required this.googleServerClientId,
  });

  factory AppEnvironment.fromDartEnvironment() {
    return const AppEnvironment(
      baseUrl: String.fromEnvironment('env.baseUrl'),
      apiBaseUrl: String.fromEnvironment('env.apiBaseUrl'),
      socketUrl: String.fromEnvironment('env.socketUrl'),
      apiEncryptionKey: String.fromEnvironment('env.apiEncryptionKey'),
      apiDecryptionKey: String.fromEnvironment('env.apiDecryptionKey'),
      googleServerClientId: String.fromEnvironment('env.googleServerClientId'),
    );
  }

  final String baseUrl;
  final String apiBaseUrl;
  final String socketUrl;
  final String apiEncryptionKey;
  final String apiDecryptionKey;
  final String googleServerClientId;

  String get imageBaseUrl => '$apiBaseUrl/uploads/';
}
