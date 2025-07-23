import 'package:flutter/material.dart';
import '../models/water_sample.dart';
import '../services/water_sample_service.dart';
import '../services/log_service.dart';

class WaterSampleScreen extends StatefulWidget {
  const WaterSampleScreen({super.key});

  @override
  State<WaterSampleScreen> createState() => _WaterSampleScreenState();
}

class _WaterSampleScreenState extends State<WaterSampleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _latController = TextEditingController();
  final _lonController = TextEditingController();
  final _elevController = TextEditingController();
  final _collectorController = TextEditingController();
  final _tempController = TextEditingController();
  final _notesController = TextEditingController();

  bool _saving = false;

  Future<void> _saveSample() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    final sample = WaterSample(
      sampleId: _idController.text,
      timestamp: DateTime.now(),
      latitude: double.tryParse(_latController.text) ?? 0,
      longitude: double.tryParse(_lonController.text) ?? 0,
      elevation: double.tryParse(_elevController.text),
      collectorName: _collectorController.text,
      temperature: double.tryParse(_tempController.text),
      notes: _notesController.text,
    );

    await WaterSampleService().insert(sample);
    await LogService()
        .log('WaterSampleSaved', contextId: sample.id, note: sample.sampleId);

    setState(() => _saving = false);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Sample saved.')));
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _idController.dispose();
    _latController.dispose();
    _lonController.dispose();
    _elevController.dispose();
    _collectorController.dispose();
    _tempController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Water Sample')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'Sample ID'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _latController,
                decoration: const InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _lonController,
                decoration: const InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _elevController,
                decoration: const InputDecoration(labelText: 'Elevation (m)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _collectorController,
                decoration: const InputDecoration(labelText: 'Collector Name'),
              ),
              TextFormField(
                controller: _tempController,
                decoration: const InputDecoration(labelText: 'Temperature (°C)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saving ? null : _saveSample,
                child: const Text('Save Sample'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
