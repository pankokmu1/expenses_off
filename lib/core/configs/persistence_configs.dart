part of 'config.dart';

class PersistenceConfigs {
  PersistenceConfigs._();

  late final Database _persistence;

  Database get persistence => _persistence;
  final String createExpensesTable =
      "CREATE TABLE expenses (amount REAL, created TIMESTAMP, description VARCHAR(255), id VARCHAR(255) PRIMARY KEY, expense_date TIMESTAMP, latitude TEXT, longitude TEXT, is_it_pending BOOLEAN, payment_receipt TEXT)";

  Future<void> _init() async {
    _persistence = await openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(createExpensesTable);
      },
    );
  }
}
