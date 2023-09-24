import 'package:expenses_off/features/expense/domain/repositories/i_expense_repository.dart';
import 'package:expenses_off/features/expense/domain/usecases/get_expenses_summaries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/expense/sample/expense_summary_sample.dart';

class MockRepository extends Mock implements IExpenseRepository {}

void main() {
  final mockRepository = MockRepository();
  late final GetExpensesSummaries getExpensesSummaries;

  setUpAll(() {
    getExpensesSummaries = GetExpensesSummaries(repository: mockRepository);
  });

  tearDown(() {
    reset(mockRepository);
  });

  group('Get expenses summaries =>', () {
    test('should return expenses summaries', () async {
      when(() => mockRepository.expensesSummaries()).thenAnswer((_) async* {
        yield [expenseSummarySample];
      });

      final result = getExpensesSummaries();

      await expectLater(
          result,
          emitsInOrder([
            [expenseSummarySample],
            emitsDone
          ]));
      verify(() => mockRepository.expensesSummaries()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
