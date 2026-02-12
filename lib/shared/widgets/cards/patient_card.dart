import 'package:flutter/material.dart';
import '../../badges/status_badge.dart';

class PatientCard extends StatelessWidget {
  final String name;
  final String tokenNumber;
  final String status;
  final VoidCallback? onTap;

  const PatientCard({
    Key? key,
    required this.name,
    required this.tokenNumber,
    required this.status,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(name[0])),
        title: Text(name, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text('Token: $tokenNumber'),
        trailing: StatusBadge(status: status),
        onTap: onTap,
      ),
    );
  }
}
