import 'package:expenses_off/features/expense/domain/entities/expense_update.dart';

ExpenseUpdate get expenseUpdateCompletedSample => ExpenseUpdate(
      amount: 13.50,
      expenseDate: DateTime.utc(2023, 09, 02, 10, 0, 0, 123),
      description: 'Despesa 1234',
      latitude: 123,
      longitude: 12,
    );
ExpenseUpdate get expenseUpdateWithoutAmountSample => ExpenseUpdate(
      expenseDate: DateTime.utc(2023, 09, 02, 10, 0, 0, 123),
      description: 'Despesa 1234',
      latitude: 123,
      longitude: 12,
    );
ExpenseUpdate get expenseUpdateWithoutExpenseDateSample => const ExpenseUpdate(
      amount: 13.50,
      description: 'Despesa 1234',
      latitude: 123,
      longitude: 12,
    );
ExpenseUpdate get expenseUpdateWithoutDescriptionSample => ExpenseUpdate(
      amount: 13.50,
      expenseDate: DateTime.utc(2023, 09, 02, 10, 0, 0, 123),
      latitude: 123,
      longitude: 12,
    );
ExpenseUpdate get expenseUpdateWithoutLatitudeSample => ExpenseUpdate(
      amount: 13.50,
      expenseDate: DateTime.utc(2023, 09, 02, 10, 0, 0, 123),
      description: 'Despesa 1234',
      longitude: 12,
    );
ExpenseUpdate get expenseUpdateWithoutLongitudeSample => ExpenseUpdate(
      amount: 13.50,
      expenseDate: DateTime.utc(2023, 09, 02, 10, 0, 0, 123),
      description: 'Despesa 1234',
      latitude: 123,
    );
