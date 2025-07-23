import 'package:flutter_test/flutter_test.dart';
import 'package:hydrofield/models/water_sample.dart';

void main() {
  test('WaterSample toMap/fromMap round trip', () {
    final sample = WaterSample(
      sampleId: 'WS001',
      timestamp: DateTime.parse('2024-01-02T14:30:00Z'),
      latitude: 40.0,
      longitude: -105.0,
      elevation: 1000.0,
      collectorName: 'Tester',
      temperature: 20.5,
      notes: 'sample note',
      photoPath: '/tmp/photo.jpg',
      cocCsvPath: '/tmp/coc.csv',
      synced: true,
    );

    final map = sample.toMap();
    final from = WaterSample.fromMap(map);

    expect(from.id, sample.id);
    expect(from.sampleId, sample.sampleId);
    expect(from.timestamp.toUtc(), sample.timestamp.toUtc());
    expect(from.latitude, sample.latitude);
    expect(from.longitude, sample.longitude);
    expect(from.elevation, sample.elevation);
    expect(from.collectorName, sample.collectorName);
    expect(from.temperature, sample.temperature);
    expect(from.notes, sample.notes);
    expect(from.photoPath, sample.photoPath);
    expect(from.cocCsvPath, sample.cocCsvPath);
    expect(from.synced, sample.synced);
  });
}

