import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String photoUrl;
  final String specialty;
  const DoctorCard({Key? key, required this.name, required this.photoUrl, required this.specialty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(photoUrl),
            radius: 32,
            onBackgroundImageError: (_, __) {},
          ),
          const SizedBox(height: 8),
          Text(name, style: Theme.of(context).textTheme.subtitle1, textAlign: TextAlign.center),
          Text(specialty, style: Theme.of(context).textTheme.caption),
        ],
      ),
    );
  }
}
