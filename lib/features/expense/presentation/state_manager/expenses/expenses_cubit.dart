import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit() : super(ExpensesInitial());
}
