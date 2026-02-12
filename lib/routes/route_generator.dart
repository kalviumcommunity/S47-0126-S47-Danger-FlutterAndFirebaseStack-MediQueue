import 'package:flutter/material.dart';
import 'app_routes.dart';

class QueueArguments {
  final String doctorId;
  QueueArguments(this.doctorId);
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case AppRoutes.queue:
        final args = settings.arguments as QueueArguments?;
        if (args == null) {
          return MaterialPageRoute(builder: (_) => const NotFoundScreen());
        }
        return MaterialPageRoute(
          builder: (_) => QueueScreen(doctorId: args.doctorId),
        );
      case AppRoutes.patientDetails:
        // For demonstration, extract patientId from arguments
        final patientId = settings.arguments as String?;
        if (patientId == null) {
          return MaterialPageRoute(builder: (_) => const NotFoundScreen());
        }
        return MaterialPageRoute(
          builder: (_) => PatientDetailsScreen(patientId: patientId),
        );
      case AppRoutes.doctorView:
        return MaterialPageRoute(builder: (_) => const DoctorViewScreen());
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case AppRoutes.widgetDemo:
        return MaterialPageRoute(builder: (_) => const WidgetRebuildDemoScreen());
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}

// Import screens for generator
import 'app_routes.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/dashboard/widget_rebuild_demo_screen.dart';
