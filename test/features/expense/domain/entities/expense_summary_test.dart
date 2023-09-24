import 'package:expenses_off/features/expense/domain/entities/expense_summary.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/expense/sample/expense_summary_sample.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final expenseMap = fixture<Map<String, dynamic>>('expense/json/expense.json');
  group('Expense Summary entity =>', () {
    group('fromMap =>', () {
      test('should convert map in Expense entity', () {
        final result = ExpenseSummary.fromMap(expenseMap);

        expect(result, expenseSummarySample);
      });
    });
    group('toMap =>', () {
      test('should convert Expense entity in a map', () {
        final result = expenseSummarySample.toMap();

        expect(expenseMap.keys, containsAll(result.keys));
        expect(expenseMap.values, containsAll(result.values));
      });
    });
    group('copyWith =>', () {
      test('should return the same entity when no parameters are passed', () {
        final result = expenseSummarySample.copyWith();

        expect(result, expenseSummarySample);
      });

      test('should return a different entity when parameters are passed', () {
        final result = expenseSummarySample.copyWith(
          amount: 1,
          created: DateTime(2023, 01, 02),
          description: 'desc',
          id: '21sda12',
        );

        expect(
            result,
            ExpenseSummary(
              amount: 1,
              created: DateTime(2023, 01, 02),
              description: 'desc',
              id: '21sda12',
            ));
      });
    });
  });
}
