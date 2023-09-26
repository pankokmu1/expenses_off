import 'package:expenses_off/core/utils/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnection extends Mock implements InternetConnection {}

void main() {
  final mockInternetConnection = MockInternetConnection();

  final networkInfo = NetworkInfo(mockInternetConnection);

  tearDown(() {
    reset(mockInternetConnection);
  });

  group('Network info =>', () {
    group('is connected', () {
      test('should validate if has connection', () async {
        when(() => mockInternetConnection.hasInternetAccess)
            .thenAnswer((_) async => true);
        final result = await networkInfo.isConnected;

        expect(result, true);
        verify(() => mockInternetConnection.hasInternetAccess).called(1);
        verifyNoMoreInteractions(mockInternetConnection);
      });
      test('should return false when occours a error', () async {
        when(() => mockInternetConnection.hasInternetAccess)
            .thenThrow((_) async => Exception());
        final result = await networkInfo.isConnected;

        expect(result, false);
        verify(() => mockInternetConnection.hasInternetAccess).called(1);
        verifyNoMoreInteractions(mockInternetConnection);
      });
    });
    group('connection status', () {
      test('should emit connection status when it changes', () async {
        when(() => mockInternetConnection.onStatusChange)
            .thenAnswer((_) async* {
          yield InternetStatus.connected;
          yield InternetStatus.disconnected;
          yield InternetStatus.connected;
        });

        final result = networkInfo.connectionStatus;

        await expectLater(
            result,
            emitsInAnyOrder([
              true,
              false,
              true,
              emitsDone,
            ]));
        verify(() => mockInternetConnection.onStatusChange).called(1);
        verifyNoMoreInteractions(mockInternetConnection);
      });
    });
  });
}
