import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'patient_queue_list.dart';
import 'queue_repository.dart';

class PatientQueueScreen extends StatelessWidget {
  const PatientQueueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the repository
    final repository = Provider.of<QueueRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Patient Queue')),
      body: StreamBuilder<List<QueueEntry>>(
        stream: repository.getQueueStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final queueEntries = snapshot.data ?? [];
          
          // Map QueueEntry to the format expected by PatientQueueList
          // Ideally PatientQueueList should be updated to accept QueueEntry
          final patients = queueEntries.map((entry) => {
            'name': 'Patient ${entry.patientId}', 
            'token': entry.token,
            'status': entry.status,
            'id': entry.id,
          }).toList();

          return PatientQueueList(patients: patients);
        },
      ),
    );
  }
}
