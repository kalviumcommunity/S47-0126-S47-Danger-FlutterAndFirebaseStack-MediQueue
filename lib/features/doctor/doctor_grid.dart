import 'package:flutter/material.dart';
import 'doctor_card.dart';

class DoctorGrid extends StatelessWidget {
  final List<Map<String, String>> doctors;
  const DoctorGrid({Key? key, required this.doctors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 3 : 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final d = doctors[index];
        return DoctorCard(
          key: ValueKey(d['name']),
          name: d['name'] ?? '',
          photoUrl: d['photoUrl'] ?? '',
          specialty: d['specialty'] ?? '',
        );
      },
    );
  }
}
