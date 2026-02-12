import 'package:flutter/material.dart';
import 'patient.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  final VoidCallback? onTap;
  final void Function(String status)? onStatusChange;
  final VoidCallback? onRemove;

  const PatientCard({
    Key? key,
    required this.patient,
    this.onTap,
    this.onStatusChange,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        title: Text('${patient.token} - ${patient.name}'),
        subtitle: Text('Status: ${patient.status}\nPhone: ${patient.phone}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton<String>(
              onSelected: (status) => onStatusChange?.call(status),
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'waiting', child: Text('Waiting')),
                const PopupMenuItem(value: 'in-progress', child: Text('In Progress')),
                const PopupMenuItem(value: 'completed', child: Text('Completed')),
              ],
              icon: const Icon(Icons.more_vert),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
