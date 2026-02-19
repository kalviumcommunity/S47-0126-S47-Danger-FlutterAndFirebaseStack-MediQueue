import 'package:flutter/material.dart';

class PatientListItem extends StatelessWidget {
  final String name;
  final String token;
  final String status;
  const PatientListItem(
      {Key? key, required this.name, required this.token, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text(name),
      subtitle: Text('Token: $token'),
      trailing: Text(status,
          style: TextStyle(
              color: status == 'waiting' ? Colors.blue : Colors.green)),
      onTap: () {},
    );
  }
}
