import 'package:flutter/material.dart';
import '../models/stream_survey.dart';
import '../services/stream_survey_service.dart';
import 'package:intl/intl.dart';

class StreamSurveyListScreen extends StatefulWidget {
  const StreamSurveyListScreen({super.key});

  @override
  State<StreamSurveyListScreen> createState() => _StreamSurveyListScreenState();
}

class _StreamSurveyListScreenState extends State<StreamSurveyListScreen> {
  List<StreamSurvey> _surveys = [];

  @override
  void initState() {
    super.initState();
    _loadSurveys();
  }

  Future<void> _loadSurveys() async {
    final db = await StreamSurveyService().getUnsynced();
    setState(() {
      _surveys = db;
    });
  }

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('yyyy-MM-dd HH:mm');
    return Scaffold(
      appBar: AppBar(title: const Text('Unsynced Stream Surveys')),
      body: _surveys.isEmpty
          ? const Center(child: Text('No unsynced surveys'))
          : ListView.builder(
              itemCount: _surveys.length,
              itemBuilder: (context, index) {
                final s = _surveys[index];
                return ListTile(
                  title: Text('Chain: \${s.chainage.toStringAsFixed(1)} m'),
                  subtitle: Text(df.format(s.timestamp)),
                  trailing: const Icon(Icons.cloud_off, color: Colors.red),
                );
              },
            ),
    );
  }
}
