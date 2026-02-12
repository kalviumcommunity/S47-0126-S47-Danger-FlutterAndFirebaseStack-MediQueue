import 'package:flutter/material.dart';
import 'patient_queue_list.dart';

class PatientQueueScreen extends StatelessWidget {
  const PatientQueueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example data
    final patients = List.generate(100, (i) => {
      'name': 'Patient $i',
      'token': 'T${i + 1}',
      'status': i % 3 == 0 ? 'completed' : 'waiting',
    });
    return Scaffold(
      appBar: AppBar(title: const Text('Patient Queue')),
      body: PatientQueueList(patients: patients),
    );
  }
}
