import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String photoUrl;
  final VoidCallback? onTap;

  const DoctorCard({
    Key? key,
    required this.name,
    required this.specialty,
    required this.photoUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(photoUrl)),
        title: Text(name, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(specialty),
        onTap: onTap,
      ),
    );
  }
}
