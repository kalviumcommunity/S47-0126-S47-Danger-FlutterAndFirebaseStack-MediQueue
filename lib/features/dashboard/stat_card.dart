import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const StatCard(
      {Key? key, required this.title, required this.count, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.15),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 16, color: color, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('$count',
                style: TextStyle(
                    fontSize: 28, color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
