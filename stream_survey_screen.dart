
import 'package:flutter/material.dart';
import '../models/stream_survey.dart';
import '../services/stream_survey_service.dart';
import '../services/log_service.dart';

class StreamSurveyScreen extends StatefulWidget {
  const StreamSurveyScreen({super.key});

  @override
  State<StreamSurveyScreen> createState() => _StreamSurveyScreenState();
}

class _StreamSurveyScreenState extends State<StreamSurveyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _chainageController = TextEditingController();
  final _elevationController = TextEditingController();
  final _angleController = TextEditingController();
  final _rlController = TextEditingController();
  final _compassController = TextEditingController();
  final _notesController = TextEditingController();

  bool _saving = false;

  Future<void> _saveSurveyPoint() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    final survey = StreamSurvey(
      timestamp: DateTime.now(),
      chainage: double.tryParse(_chainageController.text) ?? 0,
      elevation: double.tryParse(_elevationController.text),
      angle: double.tryParse(_angleController.text),
      reducedLevel: double.tryParse(_rlController.text),
      compassHeading: double.tryParse(_compassController.text),
      notes: _notesController.text,
    );

    await StreamSurveyService().insert(survey);
    await LogService().log("StreamSurveySaved", contextId: survey.id, note: "Chainage ${survey.chainage} m");

    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Stream survey point saved.')),
    );
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _chainageController.dispose();
    _elevationController.dispose();
    _angleController.dispose();
    _rlController.dispose();
    _compassController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Stream Survey Point')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _chainageController,
                decoration: const InputDecoration(labelText: 'Chainage (m)'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _elevationController,
                decoration: const InputDecoration(labelText: 'Elevation (m)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _angleController,
                decoration: const InputDecoration(labelText: 'Angle (°)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _rlController,
                decoration: const InputDecoration(labelText: 'Reduced Level (m)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _compassController,
                decoration: const InputDecoration(labelText: 'Compass Heading (°)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saving ? null : _saveSurveyPoint,
                child: const Text('Save Point'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
