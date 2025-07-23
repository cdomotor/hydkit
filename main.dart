import 'package:flutter/material.dart';
import 'screens/field_activity_session_screen.dart';
import 'screens/stream_survey_screen.dart';
import 'screens/stream_survey_list_screen.dart';
import 'screens/sample_list_screen.dart';
import 'screens/log_screen.dart';
import 'screens/water_sample_screen.dart';

void main() {
  runApp(const HydroFieldApp());
}

class HydroFieldApp extends StatelessWidget {
  const HydroFieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HydroField',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HydroField')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Field Activity Sessions'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const FieldActivitySessionScreen()),
            ),
          ),
          ListTile(
            title: const Text('New Stream Survey Point'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const StreamSurveyScreen()),
            ),
          ),
          ListTile(
            title: const Text('Unsynced Stream Surveys'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const StreamSurveyListScreen()),
            ),
          ),
          ListTile(
            title: const Text('New Water Sample'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const WaterSampleScreen()),
            ),
          ),
          ListTile(
            title: const Text('Unsynced Water Samples'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SampleListScreen()),
            ),
          ),
          ListTile(
            title: const Text('Activity Log'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const LogScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
