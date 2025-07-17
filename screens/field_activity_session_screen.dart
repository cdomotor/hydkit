
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/field_activity_session.dart';
import '../services/log_service.dart';
import '../services/db_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FieldActivitySessionScreen extends StatefulWidget {
  const FieldActivitySessionScreen({super.key});

  @override
  State<FieldActivitySessionScreen> createState() => _FieldActivitySessionScreenState();
}

class _FieldActivitySessionScreenState extends State<FieldActivitySessionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _stationCodeController = TextEditingController();
  final _userNameController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _startTime = DateTime.now();

  List<FieldActivitySession> _sessions = [];

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    final db = await DBService().database;
    final List<Map<String, dynamic>> maps =
        await db.query('field_activity_sessions', orderBy: 'startTime DESC');
    setState(() {
      _sessions = maps.map((e) => FieldActivitySession.fromMap(e)).toList();
    });
  }

  Future<void> _saveSession() async {
    if (_formKey.currentState?.validate() ?? false) {
      final session = FieldActivitySession(
        stationCode: _stationCodeController.text.trim(),
        userName: _userNameController.text.trim(),
        startTime: _startTime,
        notes: _notesController.text.trim(),
      );

      final db = await DBService().database;
      await db.insert('field_activity_sessions', session.toMap());
      await LogService().log("Session Created", contextId: session.id, note: session.stationCode);

      _stationCodeController.clear();
      _userNameController.clear();
      _notesController.clear();
      setState(() {
        _startTime = DateTime.now();
      });
      _loadSessions();
    }
  }

  @override
  void dispose() {
    _stationCodeController.dispose();
    _userNameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm');

    return Scaffold(
      appBar: AppBar(title: const Text('Field Activity Sessions')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _stationCodeController,
                    decoration: const InputDecoration(labelText: 'Station Code'),
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _userNameController,
                    decoration: const InputDecoration(labelText: 'User Name'),
                  ),
                  TextFormField(
                    controller: _notesController,
                    decoration: const InputDecoration(labelText: 'Notes'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _saveSession,
                    child: const Text('Save Session'),
                  ),
                ],
              ),
            ),
            const Divider(),
            const Text('Past Sessions', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _sessions.length,
                itemBuilder: (context, index) {
                  final s = _sessions[index];
                  return ListTile(
                    dense: true,
                    title: Text('\${s.stationCode} – \${formatter.format(s.startTime)}'),
                    subtitle: Text(s.userName ?? ''),
                    trailing: s.synced ? const Icon(Icons.cloud_done, color: Colors.green) : const Icon(Icons.cloud_off, color: Colors.red),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
