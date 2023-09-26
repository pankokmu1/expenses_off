part of 'expense_detail_cubit.dart';

sealed class ExpenseDetailState extends Equatable {
  const ExpenseDetailState();

  @override
  List<Object> get props => [];
}

final class ExpenseDetailInitial extends ExpenseDetailState {}
