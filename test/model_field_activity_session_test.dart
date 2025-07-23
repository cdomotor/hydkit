import 'package:flutter_test/flutter_test.dart';
import 'package:hydrofield/models/field_activity_session.dart';

void main() {
  test('FieldActivitySession toMap/fromMap round trip', () {
    final session = FieldActivitySession(
      stationCode: 'ST001',
      userName: 'Tester',
      startTime: DateTime.parse('2024-01-01T12:00:00Z'),
      endTime: DateTime.parse('2024-01-01T13:00:00Z'),
      notes: 'note',
      synced: true,
    );

    final map = session.toMap();
    final from = FieldActivitySession.fromMap(map);

    expect(from.id, session.id);
    expect(from.stationCode, session.stationCode);
    expect(from.userName, session.userName);
    expect(from.startTime.toUtc(), session.startTime.toUtc());
    expect(from.endTime!.toUtc(), session.endTime!.toUtc());
    expect(from.notes, session.notes);
    expect(from.synced, session.synced);
  });
}

