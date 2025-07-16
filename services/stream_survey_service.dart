
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/stream_survey.dart';

class StreamSurveyService {
  static final StreamSurveyService _instance = StreamSurveyService._internal();
  factory StreamSurveyService() => _instance;
  StreamSurveyService._internal();

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
          CREATE TABLE stream_surveys (
            id TEXT PRIMARY KEY,
            timestamp TEXT,
            chainage REAL,
            elevation REAL,
            angle REAL,
            reducedLevel REAL,
            compassHeading REAL,
            notes TEXT,
            synced INTEGER
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS stream_surveys (
            id TEXT PRIMARY KEY,
            timestamp TEXT,
            chainage REAL,
            elevation REAL,
            angle REAL,
            reducedLevel REAL,
            compassHeading REAL,
            notes TEXT,
            synced INTEGER
          )
        ''');
      },
    );

    return _db!;
  }

  Future<void> insert(StreamSurvey record) async {
    final db = await database;
    await db.insert('stream_surveys', record.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
