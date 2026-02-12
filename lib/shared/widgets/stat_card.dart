import 'package:flutter/material.dart';

/// StatCard: StatelessWidget example for displaying a statistic.
class StatCard extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  const StatCard({Key? key, required this.label, required this.value, this.color = Colors.blue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('$value', style: Theme.of(context).textTheme.headline6?.copyWith(color: color)),
            Text(label, style: Theme.of(context).textTheme.caption),
          ],
        ),
      ),
    );
  }
}
