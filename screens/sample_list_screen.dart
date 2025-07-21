import 'package:flutter/material.dart';
import '../models/water_sample.dart';
import '../services/water_sample_service.dart';
import 'package:intl/intl.dart';

class SampleListScreen extends StatefulWidget {
  const SampleListScreen({super.key});

  @override
  State<SampleListScreen> createState() => _SampleListScreenState();
}

class _SampleListScreenState extends State<SampleListScreen> {
  List<WaterSample> _samples = [];

  @override
  void initState() {
    super.initState();
    _loadSamples();
  }

  Future<void> _loadSamples() async {
    final unsynced = await WaterSampleService().getUnsynced();
    setState(() {
      _samples = unsynced;
    });
  }

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('yyyy-MM-dd HH:mm');
    return Scaffold(
      appBar: AppBar(title: const Text('Unsynced Water Samples')),
      body: _samples.isEmpty
          ? const Center(child: Text('No unsynced samples'))
          : ListView.builder(
              itemCount: _samples.length,
              itemBuilder: (context, index) {
                final s = _samples[index];
                return ListTile(
                  title: Text(s.sampleId),
                  subtitle: Text(df.format(s.timestamp)),
                  trailing: const Icon(Icons.cloud_off, color: Colors.red),
                );
              },
            ),
    );
  }
}
