import 'package:expenses_off/features/expense/domain/repositories/i_expense_repository.dart';
import 'package:expenses_off/features/expense/domain/usecases/get_expense_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/expense/sample/expense_sample.dart';

class MockRepository extends Mock implements IExpenseRepository {}

void main() {
  final mockRepository = MockRepository();
  late final GetExpenseDetail getExpenseDetail;

  setUpAll(() {
    getExpenseDetail = GetExpenseDetail(repository: mockRepository);
  });

  tearDown(() {
    reset(mockRepository);
  });

  group('Get expense detail =>', () {
    test('should return expense detail', () async {
      when(() => mockRepository.expenseDetail(expenseId: 'id23'))
          .thenAnswer((_) async* {
        yield (expenseSample, 'image.com');
      });

      final result = getExpenseDetail(expenseId: 'id23');

      await expectLater(
          result,
          emitsInOrder([
            expenseSample.copyWith(paymentReceipt: 'image.com'),
            emitsDone
          ]));
      verify(() => mockRepository.expenseDetail(expenseId: 'id23')).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
    test('should throws assert error when `expenseId` is empty', () async {
      final result = getExpenseDetail(expenseId: '');

      await expectLater(result, emitsError(isA<AssertionError>()));
      verifyZeroInteractions(mockRepository);
    });
  });
}
