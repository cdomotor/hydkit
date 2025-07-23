import 'package:flutter_test/flutter_test.dart';
import 'package:hydrofield/models/stream_survey.dart';

void main() {
  test('StreamSurvey toMap/fromMap round trip', () {
    final survey = StreamSurvey(
      timestamp: DateTime.parse('2024-01-03T10:15:00Z'),
      chainage: 50.0,
      elevation: 12.3,
      angle: 5.5,
      reducedLevel: 11.0,
      compassHeading: 180.0,
      notes: 'survey note',
      synced: true,
    );

    final map = survey.toMap();
    final from = StreamSurvey.fromMap(map);

    expect(from.id, survey.id);
    expect(from.timestamp.toUtc(), survey.timestamp.toUtc());
    expect(from.chainage, survey.chainage);
    expect(from.elevation, survey.elevation);
    expect(from.angle, survey.angle);
    expect(from.reducedLevel, survey.reducedLevel);
    expect(from.compassHeading, survey.compassHeading);
    expect(from.notes, survey.notes);
    expect(from.synced, survey.synced);
  });
}

