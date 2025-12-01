import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:students_control/core/database/database_helper.dart';

void main() {
  test('Database initialization and table creation', () async {
    // Initialize FFI
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final db = await DatabaseHelper.instance.database;
    expect(db.isOpen, true);

    // Verify tables
    final tables = await db.query(
      'sqlite_master',
      where: 'type = ?',
      whereArgs: ['table'],
    );
    final tableNames = tables.map((row) => row['name'] as String).toList();

    //print('Created tables: $tableNames');

    final expectedTables = [
      'teachers',
      'students',
      'courses',
      'schedules',
      'enrollments',
      'assessments',
      'grades',
      'attendance',
    ];

    for (final table in expectedTables) {
      expect(tableNames, contains(table), reason: 'Table $table should exist');
    }

    await db.close();
  });
}
