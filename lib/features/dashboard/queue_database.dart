import 'dart:async';
import 'patient.dart';

class QueueDatabase {
  // Simulated in-memory queue for demonstration
  final List<Patient> _queue = [];
  final StreamController<List<Patient>> _controller = StreamController.broadcast();

  Stream<List<Patient>> watchQueue() => _controller.stream;

  void addPatient(Patient patient) {
    _queue.add(patient);
    _controller.add(List.unmodifiable(_queue));
  }

  void updatePatientStatus(String id, String status) {
    final idx = _queue.indexWhere((p) => p.id == id);
    if (idx != -1) {
      _queue[idx] = Patient(
        id: _queue[idx].id,
        name: _queue[idx].name,
        token: _queue[idx].token,
        status: status,
        phone: _queue[idx].phone,
        createdAt: _queue[idx].createdAt,
      );
      _controller.add(List.unmodifiable(_queue));
    }
  }

  void removePatient(String id) {
    _queue.removeWhere((p) => p.id == id);
    _controller.add(List.unmodifiable(_queue));
  }

  void dispose() {
    _controller.close();
  }
}
