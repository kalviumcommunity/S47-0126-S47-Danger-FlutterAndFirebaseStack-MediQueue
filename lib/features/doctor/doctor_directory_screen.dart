import 'package:flutter/material.dart';
import 'doctor_grid.dart';

class DoctorDirectoryScreen extends StatelessWidget {
  const DoctorDirectoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example data
    final doctors = List.generate(12, (i) => {
      'name': 'Dr. Smith $i',
      'photoUrl': 'https://i.pravatar.cc/150?img=${i + 1}',
      'specialty': i % 2 == 0 ? 'Cardiology' : 'Pediatrics',
    });
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Directory')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: DoctorGrid(doctors: doctors),
      ),
    );
  }
}
