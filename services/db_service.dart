import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static final DBService _instance = DBService._internal();
  factory DBService() => _instance;
  DBService._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'hydrofield.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Only core DB init; tables created by feature-specific services
      },
    );
    return _db!;
  }
}
