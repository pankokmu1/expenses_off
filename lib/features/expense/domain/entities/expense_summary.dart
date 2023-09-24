import 'package:equatable/equatable.dart';
import 'package:expenses_off/core/utils/date_parse.dart';

class ExpenseSummary extends Equatable {
  const ExpenseSummary({
    required this.amount,
    required this.created,
    required this.description,
    required this.id,
  });

  final String id, description;
  final DateTime created;
  final double? amount;

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'created': dateTimeToStringWithZone(created),
      'description': description,
      'id': id,
    };
  }

  factory ExpenseSummary.fromMap(Map<String, dynamic> map) {
    return ExpenseSummary(
      amount: map['amount'],
      created: stringToDateAndTimeZone(map['expense_date']),
      description: map['description'],
      id: map['id'],
    );
  }

  ExpenseSummary copyWith({
    double? amount,
    DateTime? created,
    String? description,
    String? id,
  }) {
    return ExpenseSummary(
      amount: amount ?? this.amount,
      created: created ?? this.created,
      description: description ?? this.description,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [
        amount,
        created,
        description,
        id,
      ];
}
