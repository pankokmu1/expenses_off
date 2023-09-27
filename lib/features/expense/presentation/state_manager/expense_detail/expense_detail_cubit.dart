import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_off/core/failures/network_failures.dart';
import 'package:expenses_off/features/expense/domain/entities/expense.dart';
import 'package:expenses_off/features/expense/domain/usecases/create_expense.dart';
import 'package:expenses_off/features/expense/domain/usecases/delete_expense.dart';
import 'package:expenses_off/features/expense/domain/usecases/update_expense.dart';
import 'package:expenses_off/features/expense/presentation/models/expense_update_model.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

part 'expense_detail_state.dart';

class ExpenseDetailCubit extends Cubit<ExpenseDetailState> {
  ExpenseDetailCubit(
    this._deleteExpense,
    this._updateExpense,
    this._createExpense,
  ) : super(ExpenseDetailInitial());

  final DeleteExpense _deleteExpense;
  final UpdateExpense _updateExpense;
  final CreateExpense _createExpense;

  Expense? expense;

  Future<void> updateExpense(
    String expenseId,
    ExpenseUpdateModel expenseUpdate,
    bool isItPending,
  ) async {
    try {
      await _updateExpense(
        expenseId: expenseId,
        expenseUpdate: expenseUpdate.toMap(),
        isItPending: isItPending,
      );
      emit(ExpenseDetailSaved());
    } on NoConnectionFailure catch (e) {
      emit(ExpenseDetailWarning(message: e.message));
    } on DioError catch (e) {
      emit(ExpenseDetailWarning(message: e.message));
    } catch (e) {
      emit(const ExpenseDetailWarning(message: 'unexpected error'));
    }
  }

  Future<void> createExpense(ExpenseUpdateModel expenseModel) async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);

      final newExpense = Expense(
        amount: expenseModel.amount,
        created: DateTime.now(),
        description: expenseModel.description!,
        id: UniqueKey().toString(),
        expenseDate: expenseModel.expenseDate!,
        latitude: position.latitude,
        longitude: position.longitude,
        paymentReceipt: expenseModel.paymentReceipt,
      );
      final expenseId = await _createExpense(expense: newExpense);
      expense = expense?.copyWith(id: expenseId) ??
          newExpense.copyWith(id: expenseId);
      emit(ExpenseDetailSaved());
    } on NoConnectionFailure catch (e) {
      emit(ExpenseDetailWarning(message: e.message));
    } on DioError catch (e) {
      emit(ExpenseDetailWarning(message: e.message));
    } catch (e) {
      emit(const ExpenseDetailWarning(message: 'unexpected error'));
    }
  }

  Future<void> deleteExpense(String expenseId, bool isItPending) async {
    try {
      await _deleteExpense(
        expenseId: expenseId,
        isItPending: isItPending,
      );
      emit(ExpenseDetailDeleted());
    } on NoConnectionFailure catch (e) {
      emit(ExpenseDetailWarning(message: e.message));
    } on DioError catch (e) {
      emit(ExpenseDetailWarning(message: e.message));
    } catch (e) {
      emit(const ExpenseDetailWarning(message: 'unexpected error'));
    }
  }
}
