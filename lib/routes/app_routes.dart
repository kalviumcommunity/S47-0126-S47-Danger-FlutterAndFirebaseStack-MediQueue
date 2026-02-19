import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/dashboard/widget_rebuild_demo_screen.dart';

// Route name definitions
class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';
  static const String queue = '/queue';
  static const String patientDetails = '/patient/:id';
  static const String doctorView = '/doctor';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String widgetDemo = '/widget-demo';
  static const String bookAppointment = '/book-appointment';
}

// Placeholder screens - DoctorViewScreen is implemented in features/dashboard
// Placeholder screens - DoctorViewScreen is implemented in features/dashboard
class QueueScreen extends StatelessWidget {
  final String doctorId;
  const QueueScreen({super.key, required this.doctorId});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('QueueScreen for $doctorId')));
}

class PatientDetailsScreen extends StatelessWidget {
  final String patientId;
  const PatientDetailsScreen({super.key, required this.patientId});
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Center(child: Text('PatientDetailsScreen for $patientId')));
}

/*
class DoctorViewScreen extends StatelessWidget {
  const DoctorViewScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text('DoctorViewScreen')));
}
*/
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('SettingsScreen')));
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('ProfileScreen')));
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('404 - Page Not Found')));
}
