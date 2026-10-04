class AppEnvironment {
  const AppEnvironment({
    required this.baseUrl,
    required this.apiBaseUrl,
    required this.socketUrl,
    required this.apiEncryptionKey,
    required this.apiDecryptionKey,
    required this.googleServerClientId,
    required this.apiEncryptionIvKey,
    required this.apiDecryptionIvKey,
    required this.bucketName,
    required this.region,
  });

  factory AppEnvironment.fromDartEnvironment() {
    return const AppEnvironment(
      baseUrl: String.fromEnvironment('env.baseUrl'),
      apiBaseUrl: String.fromEnvironment('env.apiBaseUrl'),
      socketUrl: String.fromEnvironment('env.socketUrl'),
      apiEncryptionKey: String.fromEnvironment('env.apiEncryptionKey'),
      apiDecryptionKey: String.fromEnvironment('env.apiDecryptionKey'),
      googleServerClientId: String.fromEnvironment('env.googleServerClientId'),
      apiEncryptionIvKey: String.fromEnvironment('env.apiEncryptionIvKey'),
      apiDecryptionIvKey: String.fromEnvironment('env.apiDecryptionIvKey'),
      bucketName: String.fromEnvironment('env.bucketName'),
      region: String.fromEnvironment('env.region'),
    );
  }

  final String baseUrl;
  final String apiBaseUrl;
  final String socketUrl;
  final String apiEncryptionKey;
  final String apiDecryptionKey;
  final String apiEncryptionIvKey;
  final String apiDecryptionIvKey;
  final String googleServerClientId;
  final String bucketName;
  final String region;

  String get imageBaseUrl => awsImageUrl;

  String get awsImageUrl => 'https://$bucketName.s3.$region.amazonaws.com/';
}
