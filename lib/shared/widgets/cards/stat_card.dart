import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String label;
  final int value;
  final Color? color;
  const StatCard(
      {Key? key, required this.label, required this.value, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color displayColor = color ?? Theme.of(context).colorScheme.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$value',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: displayColor)),
            const SizedBox(height: 8),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
