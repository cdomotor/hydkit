
import 'package:uuid/uuid.dart';

class StreamSurvey {
  final String id;
  final DateTime timestamp;
  final double chainage;
  final double? elevation;
  final double? angle;
  final double? reducedLevel;
  final double? compassHeading;
  final String? notes;
  bool synced;

  StreamSurvey({
    String? id,
    required this.timestamp,
    required this.chainage,
    this.elevation,
    this.angle,
    this.reducedLevel,
    this.compassHeading,
    this.notes,
    this.synced = false,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'chainage': chainage,
      'elevation': elevation,
      'angle': angle,
      'reducedLevel': reducedLevel,
      'compassHeading': compassHeading,
      'notes': notes,
      'synced': synced ? 1 : 0,
    };
  }

  factory StreamSurvey.fromMap(Map<String, dynamic> map) {
    return StreamSurvey(
      id: map['id'],
      timestamp: DateTime.parse(map['timestamp']),
      chainage: map['chainage'],
      elevation: map['elevation'],
      angle: map['angle'],
      reducedLevel: map['reducedLevel'],
      compassHeading: map['compassHeading'],
      notes: map['notes'],
      synced: map['synced'] == 1,
    );
  }
}
