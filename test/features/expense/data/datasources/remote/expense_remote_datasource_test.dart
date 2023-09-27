import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:expenses_off/features/expense/data/datasources/remote/expense_remote_datasource.dart';

import '../../../../../fixtures/expense/sample/expense_sample.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  late ExpenseRemoteDatasource remoteDatasource;
  final expenseMap = expenseSample.toMap();
  final expenseId = expenseSample.id;
  const url = 'url.com';
  final mockDio = MockDio();

  setUpAll(() {
    remoteDatasource = ExpenseRemoteDatasource(mockDio, url);
  });

  tearDown(() {
    reset(mockDio);
  });
  group('Expense remote datasource =>', () {
    test('should create expense', () async {
      when(() => mockDio.post<Map<String, dynamic>>(url, data: expenseMap))
          .thenAnswer((_) async => Response(
                data: expenseMap,
                statusCode: 204,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await remoteDatasource.createExpense(
        expense: expenseMap,
      );

      expect(result, expenseId);
      verify(() => mockDio.post<Map<String, dynamic>>(url, data: expenseMap));
      verifyNoMoreInteractions(mockDio);
    });
    test('should delete expense', () async {
      when(() => mockDio.delete('$url/$expenseId'))
          .thenAnswer((_) async => Response(
                statusCode: 202,
                requestOptions: RequestOptions(path: ''),
              ));

      await remoteDatasource.deleteExpense(
        expenseId: expenseId,
      );

      verify(() => mockDio.delete('$url/$expenseId'));
      verifyNoMoreInteractions(mockDio);
    });
    test('should return expenses', () async {
      when(() => mockDio.get<Map<String, dynamic>>('$url/?page=1'))
          .thenAnswer((_) async => Response(
                data: {
                  "items": [expenseMap]
                },
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await remoteDatasource.getExpenses(page: 1);

      expect(result, [expenseMap]);
      verify(() => mockDio.get<Map<String, dynamic>>('$url/?page=1'));
      verifyNoMoreInteractions(mockDio);
    });
    test('should return empty list when api return null', () async {
      when(() => mockDio.get<Map<String, dynamic>>('$url/?page=1'))
          .thenAnswer((_) async => Response(
                data: null,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await remoteDatasource.getExpenses(page: 1);

      expect(result, []);
      verify(() => mockDio.get<Map<String, dynamic>>('$url/?page=1'));
      verifyNoMoreInteractions(mockDio);
    });
    test('should update expense', () async {
      when(() => mockDio.patch('$url/$expenseId', data: expenseMap))
          .thenAnswer((_) async => Response(
                data: expenseMap,
                statusCode: 204,
                requestOptions: RequestOptions(path: ''),
              ));

      await remoteDatasource.updateExpense(
        expenseId: expenseId,
        expense: expenseMap,
      );

      verify(() => mockDio.patch('$url/$expenseId', data: expenseMap));
      verifyNoMoreInteractions(mockDio);
    });
    test('should create multiple expenses', () async {
      final expenseMap2 = expenseSample.copyWith(id: 'seci').toMap();
      when(() => mockDio.post(url, data: expenseMap))
          .thenAnswer((_) async => Response(
                statusCode: 204,
                requestOptions: RequestOptions(path: ''),
              ));
      when(() => mockDio.post(url, data: expenseMap2))
          .thenAnswer((_) async => Response(
                statusCode: 204,
                requestOptions: RequestOptions(path: ''),
              ));

      await remoteDatasource.createMultipleExpense(
        expenses: [expenseMap, expenseMap2],
      );

      verifyInOrder([
        () => mockDio.post(url, data: expenseMap),
        () => mockDio.post(url, data: expenseMap2),
      ]);
      verifyNoMoreInteractions(mockDio);
    });
  });
}
