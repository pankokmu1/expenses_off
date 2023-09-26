part of 'expense_detail_cubit.dart';

sealed class ExpenseDetailState extends Equatable {
  const ExpenseDetailState();

  @override
  List<Object> get props => [];
}

final class ExpenseDetailInitial extends ExpenseDetailState {}

final class ExpenseDetailSaved extends ExpenseDetailState {}

final class ExpenseDetailDeleted extends ExpenseDetailState {}

final class ExpenseDetailLoading extends ExpenseDetailState {}

final class ExpenseDetailWarning extends ExpenseDetailState {
  final String message;

  const ExpenseDetailWarning({required this.message});

  @override
  List<Object> get props => [message];
}
