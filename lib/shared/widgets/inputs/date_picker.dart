import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDateSelected;

  const DatePickerField({Key? key, required this.label, this.initialDate, this.onDateSelected}) : super(key: key);

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: DateTime(now.year - 100),
      lastDate: DateTime(now.year + 10),
    );
    if (picked != null && onDateSelected != null) {
      onDateSelected!(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _pickDate(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          initialDate != null ? '${initialDate!.toLocal()}'.split(' ')[0] : 'Select date',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
