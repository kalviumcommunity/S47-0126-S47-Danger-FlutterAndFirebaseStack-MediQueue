import 'package:flutter/material.dart';
import 'patient_list_item.dart';

class PatientQueueList extends StatelessWidget {
  final List<Map<String, String>> patients;
  const PatientQueueList({Key? key, required this.patients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (patients.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.inbox, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No patients in queue', style: TextStyle(fontSize: 18)),
          ],
        ),
      );
    }
    return ListView.separated(
      itemCount: patients.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final p = patients[index];
        return PatientListItem(
          key: ValueKey(p['token']),
          name: p['name'] ?? '',
          token: p['token'] ?? '',
          status: p['status'] ?? 'waiting',
        );
      },
    );
  }
}
