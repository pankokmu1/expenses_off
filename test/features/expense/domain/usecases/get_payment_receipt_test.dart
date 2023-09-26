import 'package:expenses_off/features/expense/domain/repositories/i_expense_repository.dart';
import 'package:expenses_off/features/expense/domain/usecases/get_payment_receipt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements IExpenseRepository {}

void main() {
  final mockRepository = MockRepository();
  late final GetPaymentReceipt getPaymentReceipt;

  setUpAll(() {
    getPaymentReceipt = GetPaymentReceipt(repository: mockRepository);
  });

  tearDown(() {
    reset(mockRepository);
  });

  group('Get payment receipt =>', () {
    test('should return payment receipt', () async {
      when(() => mockRepository.paymentReceipt(expenseId: 'expens12dsa'))
          .thenAnswer((_) async => 'image.com');

      final result = await getPaymentReceipt(expenseId: 'expens12dsa');

      expect(
        result,
        'image.com',
      );
      verify(() => mockRepository.paymentReceipt(expenseId: 'expens12dsa'))
          .called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
