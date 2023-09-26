import 'package:expenses_off/features/expense/presentation/models/expense_update_model.dart';

ExpenseUpdateModel get expenseUpdateCompletedSample => ExpenseUpdateModel(
      amount: 13.50,
      expenseDate: DateTime.utc(2023, 09, 02, 10, 0, 0, 123),
      description: 'Despesa 1234',
      latitude: 123,
      longitude: 12,
    );
ExpenseUpdateModel get expenseUpdateWithoutAmountSample => ExpenseUpdateModel(
      expenseDate: DateTime.utc(2023, 09, 02, 10, 0, 0, 123),
      description: 'Despesa 1234',
      latitude: 123,
      longitude: 12,
    );
ExpenseUpdateModel get expenseUpdateWithoutExpenseDateSample =>
    const ExpenseUpdateModel(
      amount: 13.50,
      description: 'Despesa 1234',
      latitude: 123,
      longitude: 12,
    );
ExpenseUpdateModel get expenseUpdateWithoutDescriptionSample =>
    ExpenseUpdateModel(
      amount: 13.50,
      expenseDate: DateTime.utc(2023, 09, 02, 10, 0, 0, 123),
      latitude: 123,
      longitude: 12,
    );
ExpenseUpdateModel get expenseUpdateWithoutLatitudeSample => ExpenseUpdateModel(
      amount: 13.50,
      expenseDate: DateTime.utc(2023, 09, 02, 10, 0, 0, 123),
      description: 'Despesa 1234',
      longitude: 12,
    );
ExpenseUpdateModel get expenseUpdateWithoutLongitudeSample =>
    ExpenseUpdateModel(
      amount: 13.50,
      expenseDate: DateTime.utc(2023, 09, 02, 10, 0, 0, 123),
      description: 'Despesa 1234',
      latitude: 123,
    );
