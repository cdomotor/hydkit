import 'package:uuid/uuid.dart';

class WaterSample {
  final String id;
  final String sampleId;
  final DateTime timestamp;
  final double latitude;
  final double longitude;
  final double? elevation;
  final String? collectorName;
  final double? temperature;
  final String? notes;
  final String? photoPath;
  final String? cocCsvPath;
  bool synced;

  WaterSample({
    String? id,
    required this.sampleId,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    this.elevation,
    this.collectorName,
    this.temperature,
    this.notes,
    this.photoPath,
    this.cocCsvPath,
    this.synced = false,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sampleId': sampleId,
      'timestamp': timestamp.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'elevation': elevation,
      'collectorName': collectorName,
      'temperature': temperature,
      'notes': notes,
      'photoPath': photoPath,
      'cocCsvPath': cocCsvPath,
      'synced': synced ? 1 : 0,
    };
  }

  factory WaterSample.fromMap(Map<String, dynamic> map) {
    return WaterSample(
      id: map['id'],
      sampleId: map['sampleId'],
      timestamp: DateTime.parse(map['timestamp']),
      latitude: map['latitude'],
      longitude: map['longitude'],
      elevation: map['elevation'],
      collectorName: map['collectorName'],
      temperature: map['temperature'],
      notes: map['notes'],
      photoPath: map['photoPath'],
      cocCsvPath: map['cocCsvPath'],
      synced: map['synced'] == 1,
    );
  }
}
