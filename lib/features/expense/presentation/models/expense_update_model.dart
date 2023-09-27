import 'package:equatable/equatable.dart';

import 'package:expenses_off/core/utils/date_parse.dart';

class ExpenseUpdateModel extends Equatable {
  const ExpenseUpdateModel({
    this.amount,
    this.description,
    this.expenseDate,
    this.paymentReceipt,
  });

  final double? amount;
  final String? description;
  final String? paymentReceipt;
  final DateTime? expenseDate;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (amount != null) {
      map.addAll({'amount': amount});
    }
    if (description != null && description!.isNotEmpty) {
      map.addAll({'description': description});
    }
    if (expenseDate != null) {
      map.addAll({'expense_date': dateTimeToStringWithZone(expenseDate!)});
    }
    if (paymentReceipt != null) {
      map.addAll({'payment_receipt': paymentReceipt.toString()});
    }

    return map;
  }

  @override
  List<Object?> get props => [
        amount,
        description,
        expenseDate,
        paymentReceipt,
      ];

  ExpenseUpdateModel copyWith({
    double? amount,
    String? description,
    String? paymentReceipt,
    DateTime? expenseDate,
  }) {
    return ExpenseUpdateModel(
      amount: amount ?? this.amount,
      description: description ?? this.description,
      paymentReceipt: paymentReceipt ?? this.paymentReceipt,
      expenseDate: expenseDate ?? this.expenseDate,
    );
  }

  bool get hasData =>
      amount != null ||
      paymentReceipt != null ||
      expenseDate != null ||
      (description != null && description!.isNotEmpty);
  bool get isCompleted =>
      amount != null &&
      description != null &&
      paymentReceipt != null &&
      expenseDate != null &&
      description!.isNotEmpty;
}
