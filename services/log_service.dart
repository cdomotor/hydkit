import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LogService {
  static final LogService _instance = LogService._internal();
  factory LogService() => _instance;
  LogService._internal();

  Future<String> get _logFilePath async {
    final dir = await getApplicationDocumentsDirectory();
    return '\${dir.path}/activity_log.txt';
  }

  Future<void> log(String action, {String? contextId, String? note}) async {
    final filePath = await _logFilePath;
    final logLine = '[\${DateTime.now().toIso8601String()}] \$action'
        '\${contextId != null ? " | ID: \$contextId" : ""}'
        '\${note != null ? " | Note: \$note" : ""}\\n';

    final file = File(filePath);
    await file.writeAsString(logLine, mode: FileMode.append);
  }

  Future<List<String>> readLogs() async {
    final filePath = await _logFilePath;
    final file = File(filePath);
    if (!await file.exists()) return [];
    return file.readAsLines();
  }
}
