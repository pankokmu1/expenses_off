import 'package:expenses_off/core/utils/date_parse.dart';
import 'package:expenses_off/features/expense/domain/entities/expense_summary.dart';

class Expense extends ExpenseSummary {
  final String paymentReceipt;
  final DateTime expenseDate;
  final double? latitude, longitude;

  const Expense({
    required super.amount,
    required super.created,
    required super.description,
    required super.id,
    required this.expenseDate,
    required this.latitude,
    required this.longitude,
    required this.paymentReceipt,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'created': dateTimeToStringWithZone(created),
      'description': description,
      'expense_date': dateTimeToStringWithZone(expenseDate),
      'id': id,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'payment_receipt': paymentReceipt,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      amount: map['amount'],
      created: stringToDateAndTimeZone(map['expense_date']),
      description: map['description'],
      expenseDate: stringToDateAndTimeZone(map['expense_date']),
      id: map['id'],
      latitude: double.parse(map['latitude']),
      longitude: double.parse(map['longitude']),
      paymentReceipt: map['payment_receipt'],
    );
  }

  @override
  Expense copyWith({
    double? amount,
    DateTime? created,
    String? description,
    DateTime? expenseDate,
    String? id,
    double? latitude,
    double? longitude,
    String? paymentReceipt,
  }) {
    return Expense(
      amount: amount ?? this.amount,
      created: created ?? this.created,
      description: description ?? this.description,
      expenseDate: expenseDate ?? this.expenseDate,
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      paymentReceipt: paymentReceipt ?? this.paymentReceipt,
    );
  }

  @override
  List<Object?> get props => [
        amount,
        created,
        description,
        expenseDate,
        id,
        latitude,
        longitude,
        paymentReceipt,
      ];
}
