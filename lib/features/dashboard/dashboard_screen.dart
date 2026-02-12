import 'package:flutter/material.dart';
import '../../shared/widgets/index.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Demo: Stateless & Stateful Widgets')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const AppHeader(title: 'MediQueue', subtitle: 'StatelessWidget Example'),
          const SizedBox(height: 12),
          const LogoWidget(size: 64),
          const SizedBox(height: 12),
          const StatCard(label: 'Patients Today', value: 42),
          const SizedBox(height: 12),
          const PatientInfoCard(name: 'John Doe', phone: '9876543210', token: 'A12'),
          const SizedBox(height: 12),
          const FooterText(text: '© 2026 MediQueue'),
          const Divider(),
          SearchBar(onSearch: (q) {}),
          const SizedBox(height: 12),
          CountdownTimer(seconds: 10),
          const SizedBox(height: 12),
          ToggleButton(options: ['Queue', 'History'], onChanged: (i) {}),
          const SizedBox(height: 12),
          AnimatedButton(label: 'Load Data', onPressed: () async { await Future.delayed(Duration(seconds: 1)); }),
          const SizedBox(height: 12),
          FormFieldWidget(label: 'Patient Name', validator: (v) => (v == null || v.isEmpty) ? 'Required' : null),
          const SizedBox(height: 12),
          const LifecycleDemoWidget(label: 'Lifecycle Example'),
        ],
      ),
    );
  }
}
