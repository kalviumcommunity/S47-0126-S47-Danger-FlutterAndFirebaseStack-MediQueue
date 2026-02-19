import 'package:flutter/material.dart';

/// PatientInfoCard: StatelessWidget example for displaying patient details.
class PatientInfoCard extends StatelessWidget {
  final String name;
  final String phone;
  final String token;
  const PatientInfoCard(
      {Key? key, required this.name, required this.phone, required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(name),
        subtitle: Text('Phone: $phone\nToken: $token'),
      ),
    );
  }
}
