import 'package:expenses_off/features/expense/domain/entities/expense.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/expense/sample/expense_sample.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final expenseMap = fixture<Map<String, dynamic>>('expense/json/expense.json');
  group('Expense entity =>', () {
    group('fromMap =>', () {
      test('should convert map in Expense entity', () {
        final result = Expense.fromMap(expenseMap);

        expect(result, expenseSample);
      });
    });
    group('toMap =>', () {
      test('should convert Expense entity in a map', () {
        final result = expenseSample.toMap();

        expect(result.values, containsAll(expenseMap.values));
        expect(result.keys, containsAll(expenseMap.keys));
      });
    });
    group('copyWith =>', () {
      test('should return the same entity when no parameters are passed', () {
        final result = expenseSample.copyWith();

        expect(result, expenseSample);
      });

      test('should return a different entity when parameters are passed', () {
        final result = expenseSample.copyWith(
          amount: 1,
          created: DateTime(2023, 01, 02),
          description: 'desc',
          expenseDate: DateTime(2023, 01, 01),
          id: '21sda12',
          latitude: 12.0,
          longitude: -10,
          paymentReceipt: 'url.com',
          isItPending: true,
        );

        expect(
            result,
            Expense(
              amount: 1,
              created: DateTime(2023, 01, 02),
              description: 'desc',
              expenseDate: DateTime(2023, 01, 01),
              id: '21sda12',
              latitude: 12.0,
              longitude: -10,
              paymentReceipt: 'url.com',
              isItPending: true,
            ));
      });
    });
  });
}
