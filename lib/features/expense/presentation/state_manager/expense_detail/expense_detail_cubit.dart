import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'expense_detail_state.dart';

class ExpenseDetailCubit extends Cubit<ExpenseDetailState> {
  ExpenseDetailCubit() : super(ExpenseDetailInitial());
}
