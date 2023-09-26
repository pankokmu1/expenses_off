import 'package:equatable/equatable.dart';
import 'package:expenses_off/core/utils/date_parse.dart';

class Expense extends Equatable {
  final double? amount, latitude, longitude;
  final DateTime created, expenseDate;
  final String id, description;
  final bool isItPending;
  final String? paymentReceipt;

  const Expense({
    required this.amount,
    required this.created,
    required this.description,
    required this.id,
    required this.expenseDate,
    required this.latitude,
    required this.longitude,
    required this.paymentReceipt,
    this.isItPending = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'created': dateTimeToStringWithZone(created),
      'description': description,
      'expense_date': dateTimeToStringWithZone(expenseDate),
      'id': id,
      'is_it_peding': isItPending,
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
      isItPending: map['is_it_peding'] ?? false,
      latitude: double.parse(map['latitude']),
      longitude: double.parse(map['longitude']),
      paymentReceipt: map['payment_receipt'],
    );
  }

  Expense copyWith({
    double? amount,
    DateTime? created,
    String? description,
    DateTime? expenseDate,
    String? id,
    bool? isItPending,
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
      isItPending: isItPending ?? this.isItPending,
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
        isItPending,
        latitude,
        longitude,
        paymentReceipt,
      ];
}
