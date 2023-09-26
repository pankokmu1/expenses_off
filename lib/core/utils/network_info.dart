import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;

  Stream<bool> get connectionStatus;
}

class NetworkInfo implements INetworkInfo {
  final InternetConnection _connectionChecker;

  NetworkInfo(this._connectionChecker);

  @override
  Future<bool> get isConnected async {
    try {
      return await _connectionChecker.hasInternetAccess;
    } catch (_) {
      return false;
    }
  }

  @override
  Stream<bool> get connectionStatus async* {
    yield* _connectionChecker.onStatusChange.map<bool>(
      (status) => status == InternetStatus.connected,
    );
  }
}
