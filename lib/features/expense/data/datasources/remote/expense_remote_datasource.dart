import 'package:dio/dio.dart';

import 'i_expense_remote_datasource.dart';

class ExpenseRemoteDatasource implements IExpenseRemoteDatasource {
  ExpenseRemoteDatasource(this._dio, [String? url])
      : _url = url ??
            'https://go-bd-api-3iyuzyysfa-uc.a.run.app/api/collections/expense_xfqBre/records';

  final Dio _dio;
  final String _url;

  @override
  Future<String> createExpense({
    required Map<String, dynamic> expense,
  }) async {
    return await _dio
        .post<Map<String, dynamic>>(_url, data: expense)
        .then((response) => response.data?['id']);
  }

  @override
  Future<void> deleteExpense({
    required String expenseId,
  }) async {
    await _dio.delete('$_url/$expenseId');
  }

  @override
  Future<List<Map<String, dynamic>>> getExpenses({
    required int page,
  }) async {
    final response =
        await _dio.get<List<Map<String, dynamic>>>('$_url/?page=$page');
    return response.data ?? [];
  }

  @override
  Future<void> getPaymentReceipt({
    required String expenseId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateExpense({
    required String expenseId,
    required Map<String, dynamic> expense,
  }) async {
    await _dio.patch('$_url/$expenseId', data: expense);
  }

  @override
  Future<void> createMultipleExpense({
    required List<Map<String, dynamic>> expenses,
  }) async {
    final posts = <Future<dynamic>>[];
    for (var expense in expenses) {
      posts.add(_dio.post(_url, data: expense));
    }

    await Future.wait(posts);
  }
}
