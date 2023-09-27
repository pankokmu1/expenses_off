part of 'expenses_cubit.dart';

abstract class ExpensesState extends Equatable {
  const ExpensesState();

  @override
  List<Object> get props => [];
}

class ExpensesLoaded extends ExpensesState {
  final List<Expense> expenses;

  const ExpensesLoaded({required this.expenses});
}

class ExpensePaymentReceiptLoaded extends ExpensesState {
  final String paymentReceipt;

  const ExpensePaymentReceiptLoaded({required this.paymentReceipt});
}

class ExpensesLoading extends ExpensesState {}

class ExpensesEmpty extends ExpensesState {}

class ExpensesError extends ExpensesState {
  final String message;

  const ExpensesError({required this.message});

  @override
  List<Object> get props => [message];
}

class ExpensesWarning extends ExpensesState {
  final String message;

  const ExpensesWarning({required this.message});

  @override
  List<Object> get props => [message];
}
