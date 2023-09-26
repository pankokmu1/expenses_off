import 'package:expenses_off/core/failures/network_failures.dart';
import 'package:expenses_off/features/expense/data/datasources/local/i_expense_local_datasource.dart';
import 'package:expenses_off/features/expense/data/datasources/remote/i_expense_remote_datasource.dart';
import 'package:expenses_off/features/expense/data/repositories/expense_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/expense/sample/expense_sample.dart';
import '../../../../mocks/mocks.dart';

class MockLocalDatasource extends Mock implements IExpenseLocalDatasource {}

class MockRemoteDatasource extends Mock implements IExpenseRemoteDatasource {}

void main() {
  final mockLocalDatasource = MockLocalDatasource();
  final mockRemoteDatasource = MockRemoteDatasource();
  final mockNetworkInfo = MockNetworkInfo();
  final expenseMap = expenseSample.toMap();
  final expenseMapWithIsItPeddingTrue =
      expenseSample.copyWith(isItPending: true).toMap();

  late ExpenseRepository repository;

  setUpAll(() {
    repository = ExpenseRepository(
      mockLocalDatasource,
      mockRemoteDatasource,
      mockNetworkInfo,
    );
  });
  tearDown(() {
    reset(mockLocalDatasource);
    reset(mockRemoteDatasource);
    reset(mockNetworkInfo);
  });

  group('Expense repository =>', () {
    group('create expense', () {
      test('should create expense', () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer(
          (_) async => true,
        );
        when(() => mockRemoteDatasource.createExpense(expense: expenseMap))
            .thenAnswer((_) async => 'expenseId');

        final result = await repository.creteExpense(expense: expenseSample);

        expect(result, 'expenseId');
        verifyInOrder([
          () => mockNetworkInfo.isConnected,
          () => mockRemoteDatasource.createExpense(expense: expenseMap)
        ]);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockRemoteDatasource);
        verifyZeroInteractions(mockLocalDatasource);
      });
      test(
          'should throw a `NoConnectionFailure` and save expense in cache when don`t have connection',
          () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer(
          (_) async => false,
        );
        when(() => mockLocalDatasource.saveExpense(
            expense: expenseMapWithIsItPeddingTrue)).thenAnswer((_) async {});

        result() async => await repository.creteExpense(expense: expenseSample);

        await expectLater(result, throwsA(isA<NoConnectionFailure>()));
        verifyInOrder([
          () => mockNetworkInfo.isConnected,
          () => mockLocalDatasource.saveExpense(
              expense: expenseMapWithIsItPeddingTrue)
        ]);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockLocalDatasource);
        verifyZeroInteractions(mockRemoteDatasource);
      });
      test('should save expense in cache when occurs any error', () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDatasource.createExpense(expense: expenseMap))
            .thenThrow(Exception());
        when(() => mockLocalDatasource.saveExpense(
            expense: expenseMapWithIsItPeddingTrue)).thenAnswer((_) async {});

        result() async => await repository.creteExpense(expense: expenseSample);

        await expectLater(result, throwsA(isA<Exception>()));
        verifyInOrder([
          () => mockNetworkInfo.isConnected,
          () => mockRemoteDatasource.createExpense(expense: expenseMap),
          () => mockLocalDatasource.saveExpense(
              expense: expenseMapWithIsItPeddingTrue)
        ]);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockLocalDatasource);
        verifyNoMoreInteractions(mockRemoteDatasource);
      });
    });
    //TODO: create more tests
  });
}
