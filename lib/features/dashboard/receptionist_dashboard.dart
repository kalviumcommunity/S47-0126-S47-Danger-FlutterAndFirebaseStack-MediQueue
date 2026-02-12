import 'package:flutter/material.dart';

import 'patient.dart';
import 'patient_card.dart';
import 'stat_card.dart';
import 'queue_database.dart';

class ReceptionistDashboard extends StatefulWidget {
  const ReceptionistDashboard({Key? key}) : super(key: key);
  @override
  _ReceptionistDashboardState createState() => _ReceptionistDashboardState();
}

class _ReceptionistDashboardState extends State<ReceptionistDashboard> {
  final QueueDatabase _db = QueueDatabase();
  List<Patient> _queue = [];
  String _search = '';
  String? _filterStatus;
  Stream<List<Patient>>? _queueStream;
  StreamSubscription<List<Patient>>? _queueSub;

  @override
  void initState() {
    super.initState();
    _queueStream = _db.watchQueue();
    _queueSub = _queueStream!.listen((data) {
      setState(() => _queue = data);
    });
  }

  @override
  void dispose() {
    _queueSub?.cancel();
    _db.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Queue Dashboard'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _refreshQueue),
          IconButton(icon: const Icon(Icons.filter_list), onPressed: _showFilters),
        ],
      ),
      body: Column(
        children: [
          _buildStats(),
          _buildSearchBar(),
          Expanded(child: _buildQueueList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _addPatient,
      ),
    );
  }

  Widget _buildStats() {
    final waiting = _queue.where((p) => p.status == 'waiting').length;
    final inProgress = _queue.where((p) => p.status == 'in-progress').length;
    final completed = _queue.where((p) => p.status == 'completed').length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatCard(title: 'Waiting', count: waiting, color: Colors.orange),
        StatCard(title: 'In Progress', count: inProgress, color: Colors.blue),
        StatCard(title: 'Completed', count: completed, color: Colors.green),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Search by name or token',
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (value) => setState(() => _search = value),
      ),
    );
  }

  Widget _buildQueueList() {
    final filtered = _queue.where((p) {
      final matchesSearch = _search.isEmpty ||
        p.name.toLowerCase().contains(_search.toLowerCase()) ||
        p.token.toLowerCase().contains(_search.toLowerCase());
      final matchesFilter = _filterStatus == null || p.status == _filterStatus;
      return matchesSearch && matchesFilter;
    }).toList();
    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final patient = filtered[index];
        return PatientCard(
          patient: patient,
          onTap: () => _viewDetails(patient),
          onStatusChange: (status) => _updateStatus(patient, status),
          onRemove: () => _removePatient(patient),
        );
      },
    );
  }

  void _refreshQueue() {
    // No-op: real-time updates handled by stream
    setState(() {});
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('All'),
            onTap: () => setState(() { _filterStatus = null; Navigator.pop(context); }),
          ),
          ListTile(
            title: const Text('Waiting'),
            onTap: () => setState(() { _filterStatus = 'waiting'; Navigator.pop(context); }),
          ),
          ListTile(
            title: const Text('In Progress'),
            onTap: () => setState(() { _filterStatus = 'in-progress'; Navigator.pop(context); }),
          ),
          ListTile(
            title: const Text('Completed'),
            onTap: () => setState(() { _filterStatus = 'completed'; Navigator.pop(context); }),
          ),
        ],
      ),
    );
  }

  void _addPatient() {
    // Example: Add a dummy patient (replace with real form/dialog in production)
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final patient = Patient(
      id: id,
      name: 'Patient $id',
      token: 'A-${(_queue.length + 1).toString().padLeft(3, '0')}',
      status: 'waiting',
      phone: '1234567890',
      createdAt: DateTime.now(),
    );
    _db.addPatient(patient);
  }

  void _viewDetails(Patient patient) {
    // Show simple dialog with patient details
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Patient Details'),
        content: Text('Name: ${patient.name}\nToken: ${patient.token}\nStatus: ${patient.status}\nPhone: ${patient.phone}'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ),
    );
  }

  void _updateStatus(Patient patient, String status) {
    _db.updatePatientStatus(patient.id, status);
  }

  void _removePatient(Patient patient) {
    _db.removePatient(patient.id);
  }
}
