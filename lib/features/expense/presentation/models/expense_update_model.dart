import 'package:equatable/equatable.dart';
import 'package:expenses_off/core/utils/date_parse.dart';

class ExpenseUpdateModel extends Equatable {
  const ExpenseUpdateModel({
    this.amount,
    this.description,
    this.expenseDate,
    this.longitude,
    this.latitude,
  });

  final double? amount, latitude, longitude;
  final String? description;
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
    if (latitude != null) {
      map.addAll({'latitude': latitude.toString()});
    }
    if (longitude != null) {
      map.addAll({'longitude': longitude.toString()});
    }
    return map;
  }

  @override
  List<Object?> get props => [
        amount,
        description,
        expenseDate,
        latitude,
        longitude,
      ];
}
