import 'package:expenses_off/features/expense/domain/entities/expense.dart';

Expense get expenseSample => Expense(
      amount: 13.50,
      created: DateTime.utc(2023, 09, 02, 10, 0, 0, 123),
      description: 'Despesa 1234',
      expenseDate: DateTime.utc(2023, 09, 02, 10, 0, 0, 123),
      id: 'asde21edsa',
      latitude: 81.121212,
      longitude: 41.232323,
      paymentReceipt:
          'https://imobiliarias.superlogica.com/hc/article_attachments/360081669333/comp..png',
    );
