import 'package:dio/dio.dart';
import 'package:expenses_off/core/utils/network_info.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockNetworkInfo extends Mock implements INetworkInfo {}
