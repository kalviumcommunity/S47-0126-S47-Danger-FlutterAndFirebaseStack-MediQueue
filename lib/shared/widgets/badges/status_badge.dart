import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  const StatusBadge({Key? key, required this.status}) : super(key: key);

  Color get _color {
    switch (status.toLowerCase()) {
      case 'waiting':
        return Colors.orange;
      case 'in-progress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _color),
      ),
      child: Text(
        status,
        style: TextStyle(color: _color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
