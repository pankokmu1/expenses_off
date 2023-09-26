import 'package:expenses_off/features/expense/domain/repositories/i_expense_repository.dart';
import 'package:expenses_off/features/expense/domain/usecases/upload_expenses_from_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/expense/sample/expense_sample.dart';

class MockRepository extends Mock implements IExpenseRepository {}

void main() {
  final mockRepository = MockRepository();
  late final UploadExpensesFromCache uploadExpensesFromCache;

  setUpAll(() {
    uploadExpensesFromCache = UploadExpensesFromCache(
      repository: mockRepository,
    );
  });

  tearDown(() {
    reset(mockRepository);
  });

  group('Upload expenses from cache =>', () {
    test('should return expenses', () async {
      when(() => mockRepository.uploadExpensesFromCache())
          .thenAnswer((_) async {});
      when(() => mockRepository.expenses(page: 1))
          .thenAnswer((_) async => [expenseSample]);

      await uploadExpensesFromCache();

      verify(() => mockRepository.uploadExpensesFromCache()).called(1);
      verify(() => mockRepository.expenses(page: 1)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
