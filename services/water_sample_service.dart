import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/water_sample.dart';

class WaterSampleService {
  static final WaterSampleService _instance = WaterSampleService._internal();
  factory WaterSampleService() => _instance;
  WaterSampleService._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'hydrofield.db');

    _db = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE water_samples (
            id TEXT PRIMARY KEY,
            sampleId TEXT,
            timestamp TEXT,
            latitude REAL,
            longitude REAL,
            elevation REAL,
            collectorName TEXT,
            temperature REAL,
            notes TEXT,
            photoPath TEXT,
            cocCsvPath TEXT,
            synced INTEGER
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS water_samples (
            id TEXT PRIMARY KEY,
            sampleId TEXT,
            timestamp TEXT,
            latitude REAL,
            longitude REAL,
            elevation REAL,
            collectorName TEXT,
            temperature REAL,
            notes TEXT,
            photoPath TEXT,
            cocCsvPath TEXT,
            synced INTEGER
          )
        ''');
      },
    );

    return _db!;
  }

  Future<void> insert(WaterSample sample) async {
    final db = await database;
    await db.insert('water_samples', sample.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<WaterSample>> getUnsynced() async {
    final db = await database;
    final maps = await db.query('water_samples', where: 'synced = 0');
    return maps.map((e) => WaterSample.fromMap(e)).toList();
  }

  Future<void> markSynced(String id) async {
    final db = await database;
    await db.update('water_samples', {'synced': 1},
        where: 'id = ?', whereArgs: [id]);
  }
}
