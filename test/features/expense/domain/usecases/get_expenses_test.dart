import 'package:expenses_off/features/expense/domain/repositories/i_expense_repository.dart';
import 'package:expenses_off/features/expense/domain/usecases/get_expenses.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/expense/sample/expense_sample.dart';

class MockRepository extends Mock implements IExpenseRepository {}

void main() {
  final mockRepository = MockRepository();
  late final GetExpenses getExpensesSummaries;

  setUpAll(() {
    getExpensesSummaries = GetExpenses(repository: mockRepository);
  });

  tearDown(() {
    reset(mockRepository);
  });

  group('Get expenses =>', () {
    test('should return expenses', () async {
      when(() => mockRepository.expenses(page: 1))
          .thenAnswer((_) async => [expenseSample]);

      final result = await getExpensesSummaries(page: 1);

      await expectLater(
        result,
        [expenseSample],
      );
      verify(() => mockRepository.expenses(page: 1)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
