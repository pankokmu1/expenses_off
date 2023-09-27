part of 'expense_detail_cubit.dart';

abstract class ExpenseDetailState extends Equatable {
  const ExpenseDetailState();

  @override
  List<Object> get props => [];
}

class ExpenseDetailInitial extends ExpenseDetailState {}

class ExpenseDetailSaved extends ExpenseDetailState {}

class ExpenseDetailDeleted extends ExpenseDetailState {}

class ExpenseDetailLoading extends ExpenseDetailState {}

class ExpenseDetailWarning extends ExpenseDetailState {
  final String message;

  const ExpenseDetailWarning({required this.message});

  @override
  List<Object> get props => [message];
}
