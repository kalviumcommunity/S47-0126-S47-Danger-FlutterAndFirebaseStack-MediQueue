import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/widgets/index.dart';
import '../../shared/widgets/responsive_builder.dart';
import '../../core/constants/app_spacing.dart';
import '../../services/sync_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SyncService>(
      builder: (context, syncService, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Dashboard Demo: Stateless & Stateful Widgets')),
          body: Column(
            children: [
              if (!syncService.isOnline)
                Container(
                  color: Colors.red,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Offline Mode - Changes will sync when online',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    // Responsive header with logo and menu
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const LogoWidget(size: 40),
                        const Spacer(),
                        IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const AppHeader(title: 'MediQueue', subtitle: 'Responsive Layout Demo'),
                    const SizedBox(height: AppSpacing.lg),
                    // Responsive stat cards
                    ResponsiveBuilder(
                      builder: (context, isTablet) {
                        if (isTablet) {
                          return Row(
                            children: const [
                              Expanded(child: StatCard(label: 'Patients', value: 42)),
                              SizedBox(width: AppSpacing.md),
                              Expanded(child: StatCard(label: 'Doctors', value: 7, color: Colors.green)),
                              SizedBox(width: AppSpacing.md),
                              Expanded(child: StatCard(label: 'Tokens', value: 120, color: Colors.orange)),
                            ],
                          );
                        } else {
                          return Column(
                            children: const [
                              StatCard(label: 'Patients', value: 42),
                              SizedBox(height: AppSpacing.sm),
                              StatCard(label: 'Doctors', value: 7, color: Colors.green),
                              SizedBox(height: AppSpacing.sm),
                              StatCard(label: 'Tokens', value: 120, color: Colors.orange),
                            ],
                          );
                        }
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    // Patient card with responsive padding
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isTablet = constraints.maxWidth > 600;
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: isTablet ? AppSpacing.xl : AppSpacing.sm),
                          child: const PatientInfoCard(name: 'John Doe', phone: '9876543210', token: 'A12'),
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    // Responsive form layout
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          children: [
                            FormFieldWidget(label: 'Name', validator: (v) => (v == null || v.isEmpty) ? 'Required' : null),
                            const SizedBox(height: AppSpacing.md),
                            FormFieldWidget(label: 'Phone', validator: (v) => (v == null || v.isEmpty) ? 'Required' : null),
                            const SizedBox(height: AppSpacing.lg),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(onPressed: () {}, child: const Text('Submit')),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    // Queue list item example
                    Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: AppSpacing.sm),
                        const Expanded(child: Text('Patient Name')), // Expands to fill
                        IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () {}),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    // Prevent overflow with scroll view
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(10, (i) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                          child: Chip(label: Text('Token ${i + 1}')),
                        )),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    // FittedBox for long text
                    const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text('Long text that should fit in a single line and not overflow'),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    // Footer
                    const FooterText(text: '© 2026 MediQueue'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
