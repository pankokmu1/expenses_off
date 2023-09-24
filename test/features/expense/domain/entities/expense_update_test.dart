import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/expense/sample/expense_update_sample.dart';

void main() {
  group('Expense Update entity =>', () {
    group('toMap =>', () {
      test('should convert Expense Update entity in a map with all parameters',
          () {
        final result = expenseUpdateCompletedSample.toMap();

        expect(result, {
          'amount': 13.50,
          'description': 'Despesa 1234',
          'expense_date': "2023-09-02 10:00:00.123Z",
          'latitude': '123.0',
          'longitude': '12.0',
        });
      });
      test('should convert Expense Update entity in a map without amount', () {
        final result = expenseUpdateWithoutAmountSample.toMap();

        expect(result, {
          'description': 'Despesa 1234',
          'expense_date': "2023-09-02 10:00:00.123Z",
          'latitude': '123.0',
          'longitude': '12.0',
        });
      });
      test('should convert Expense Update entity in a map without description',
          () {
        final result = expenseUpdateWithoutDescriptionSample.toMap();

        expect(result, {
          'amount': 13.50,
          'expense_date': "2023-09-02 10:00:00.123Z",
          'latitude': '123.0',
          'longitude': '12.0',
        });
      });
      test('should convert Expense Update entity in a map without expense date',
          () {
        final result = expenseUpdateWithoutExpenseDateSample.toMap();

        expect(result, {
          'amount': 13.50,
          'description': 'Despesa 1234',
          'latitude': '123.0',
          'longitude': '12.0',
        });
      });
      test('should convert Expense Update entity in a map without latitude',
          () {
        final result = expenseUpdateWithoutLatitudeSample.toMap();

        expect(result, {
          'amount': 13.50,
          'description': 'Despesa 1234',
          'expense_date': "2023-09-02 10:00:00.123Z",
          'longitude': '12.0',
        });
      });
      test('should convert Expense Update entity in a map without longitude',
          () {
        final result = expenseUpdateWithoutLongitudeSample.toMap();

        expect(result, {
          'amount': 13.50,
          'description': 'Despesa 1234',
          'expense_date': "2023-09-02 10:00:00.123Z",
          'latitude': '123.0',
        });
      });
    });
  });
}
