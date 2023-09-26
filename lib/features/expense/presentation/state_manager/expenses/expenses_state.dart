part of 'expenses_cubit.dart';

abstract class ExpensesState extends Equatable {
  const ExpensesState();

  @override
  List<Object> get props => [];
}

final class ExpensesLoaded extends ExpensesState {
  final List<Expense> expenses;

  const ExpensesLoaded({required this.expenses});
}

final class ExpensePaymentReceiptLoaded extends ExpensesState {
  final String paymentReceipt;

  const ExpensePaymentReceiptLoaded({required this.paymentReceipt});
}

final class ExpensesLoading extends ExpensesState {}

final class ExpensesEmpty extends ExpensesState {}

final class ExpensesError extends ExpensesState {
  final String message;

  const ExpensesError({required this.message});

  @override
  List<Object> get props => [message];
}

final class ExpensesWarning extends ExpensesState {
  final String message;

  const ExpensesWarning({required this.message});

  @override
  List<Object> get props => [message];
}
