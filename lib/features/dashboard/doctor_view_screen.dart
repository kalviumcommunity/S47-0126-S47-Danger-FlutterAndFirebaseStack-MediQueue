import 'dart:async';
import 'package:flutter/material.dart';
import 'patient.dart';
import 'queue_database.dart';

class DoctorViewScreen extends StatefulWidget {
  const DoctorViewScreen({Key? key}) : super(key: key);
  @override
  State<DoctorViewScreen> createState() => _DoctorViewScreenState();
}

class _DoctorViewScreenState extends State<DoctorViewScreen> {
  final QueueDatabase _db = QueueDatabase();
  Patient? _currentPatient;
  Patient? _nextPatient;
  Timer? _timer;
  int _seconds = 0;
  StreamSubscription<List<Patient>>? _queueSub;

  @override
  void initState() {
    super.initState();
    _queueSub = _db.watchQueue().listen(_onQueueUpdate);
    _fetchNextPatient();
  }

  @override
  void dispose() {
    _queueSub?.cancel();
    _timer?.cancel();
    _db.dispose();
    super.dispose();
  }

  void _onQueueUpdate(List<Patient> queue) {
    if (_currentPatient == null) {
      _fetchNextPatient();
    } else {
      // Update next patient preview
      final waiting = queue.where((p) => p.status == 'waiting').toList();
      setState(() {
        _nextPatient = waiting.isNotEmpty ? waiting.first : null;
      });
    }
  }

  void _fetchNextPatient() {
    final queue = _db.queue.where((p) => p.status == 'waiting').toList();
    if (queue.isNotEmpty) {
      setState(() {
        _currentPatient = queue.first;
        _nextPatient = queue.length > 1 ? queue[1] : null;
        _db.updatePatientStatus(_currentPatient!.id, 'in-progress');
        _seconds = 0;
      });
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() => _seconds++);
      });
    } else {
      setState(() {
        _currentPatient = null;
        _nextPatient = null;
        _seconds = 0;
      });
      _timer?.cancel();
    }
  }

  void _markComplete() {
    if (_currentPatient != null) {
      _db.updatePatientStatus(_currentPatient!.id, 'completed');
      setState(() => _currentPatient = null);
      _fetchNextPatient();
    }
  }

  void _viewHistory() {
    // TODO: Implement patient history view
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor View'),
        actions: [
          IconButton(icon: const Icon(Icons.history), onPressed: _viewHistory),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCurrentPatientCard(),
            const SizedBox(height: 24),
            _buildNextPatientPreview(),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _currentPatient == null ? _fetchNextPatient : null,
                    child: const Text('Call Next Patient'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _currentPatient != null ? _markComplete : null,
                    child: const Text('Mark Complete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPatientCard() {
    if (_currentPatient == null) {
      return Card(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Text('No patient in consultation', style: TextStyle(fontSize: 20, color: Colors.grey[700])),
          ),
        ),
      );
    }
    return Card(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Patient', style: TextStyle(fontSize: 16, color: Colors.blue[700])),
            const SizedBox(height: 8),
            Text('${_currentPatient!.name} (${_currentPatient!.token})', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Phone: ${_currentPatient!.phone}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.timer, color: Colors.blue),
                const SizedBox(width: 8),
                Text(_formatDuration(_seconds), style: const TextStyle(fontSize: 18)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextPatientPreview() {
    if (_nextPatient == null) {
      return Card(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(child: Text('No next patient in queue', style: TextStyle(color: Colors.grey[600]))),
        ),
      );
    }
    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.person, color: Colors.green),
            const SizedBox(width: 12),
            Text('${_nextPatient!.name} (${_nextPatient!.token})', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  String _formatDuration(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}
