
import 'package:uuid/uuid.dart';

class FieldActivitySession {
  final String id;
  final String stationCode;
  final String? userName;
  final DateTime startTime;
  final DateTime? endTime;
  final String? notes;
  bool synced;

  FieldActivitySession({
    String? id,
    required this.stationCode,
    this.userName,
    required this.startTime,
    this.endTime,
    this.notes,
    this.synced = false,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stationCode': stationCode,
      'userName': userName,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'notes': notes,
      'synced': synced ? 1 : 0,
    };
  }

  factory FieldActivitySession.fromMap(Map<String, dynamic> map) {
    return FieldActivitySession(
      id: map['id'],
      stationCode: map['stationCode'],
      userName: map['userName'],
      startTime: DateTime.parse(map['startTime']),
      endTime: map['endTime'] != null ? DateTime.parse(map['endTime']) : null,
      notes: map['notes'],
      synced: map['synced'] == 1,
    );
  }
}
