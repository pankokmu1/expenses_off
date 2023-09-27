part of 'config.dart';

String? globalToken;

class HttpClientConfigs {
  HttpClientConfigs._();

  late final Dio _client;

  Dio get client => _client;

  Future<void> _init() async {
    _client = Dio()
      ..options = BaseOptions(
        connectTimeout: 5000,
        contentType: 'application/json',
        followRedirects: true,
      )
      ..interceptors.add(_interceptor);
  }

  InterceptorsWrapper get _interceptor => InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (globalToken != null) {
            options.headers["Authorization"] = globalToken!;
          }

          handler.next(options);
        },
      );
}
