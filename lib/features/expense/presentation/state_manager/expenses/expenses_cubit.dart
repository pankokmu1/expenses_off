import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_off/core/failures/network_failures.dart';
import 'package:expenses_off/features/expense/domain/entities/expense.dart';
import 'package:expenses_off/features/expense/domain/usecases/get_expenses.dart';
import 'package:expenses_off/features/expense/domain/usecases/get_payment_receipt.dart';
import 'package:flutter/material.dart';

part 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit(
    this._getExpenses,
    this._getPaymentReceipt,
  ) : super(ExpensesLoading());

  final GetExpenses _getExpenses;
  final GetPaymentReceipt _getPaymentReceipt;
  @visibleForTesting
  final List<Expense> expenses = [];

  Future<void> getExpenses({required int page}) async {
    try {
      final newExpenses = await _getExpenses(
        page: page,
      );
      if (expenses.isEmpty && newExpenses.isEmpty) {
        emit(ExpensesEmpty());
      } else {
        expenses.addAll(newExpenses);
        emit(ExpensesLoaded(expenses: newExpenses));
      }
    } on NoConnectionFailure catch (e) {
      if (expenses.isEmpty) {
        emit(ExpensesError(message: e.message));
      } else {
        emit(ExpensesWarning(message: e.message));
      }
    } on DioError catch (e) {
      if (expenses.isEmpty) {
        emit(ExpensesError(message: e.message));
      } else {
        emit(ExpensesWarning(message: e.message));
      }
    } catch (e) {
      if (expenses.isEmpty) {
        emit(const ExpensesError(message: 'unexpected error'));
      } else {
        emit(const ExpensesWarning(message: 'unexpected error'));
      }
    }
  }

  Future<void> getPaymentReceipt({required String expenseId}) async {
    try {
      final paymentReceipt = await _getPaymentReceipt(
        expenseId: expenseId,
      );
      emit(ExpensePaymentReceiptLoaded(paymentReceipt: paymentReceipt));
    } on NoConnectionFailure catch (e) {
      emit(ExpensesWarning(message: e.message));
    } on DioError catch (e) {
      emit(ExpensesWarning(message: e.message));
    } catch (e) {
      emit(const ExpensesWarning(message: 'unexpected error'));
    }
  }
}
