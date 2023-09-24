part of 'expense_cubit.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

class ExpenseInitial extends ExpenseState {}
