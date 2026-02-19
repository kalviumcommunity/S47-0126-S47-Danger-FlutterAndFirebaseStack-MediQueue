import 'package:flutter/material.dart';
import 'app_routes.dart';

import '../features/auth/screens/login_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/dashboard/doctor_view_screen.dart';
import '../features/dashboard/widget_rebuild_demo_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/auth/screens/forgot_password_screen.dart';
import '../features/auth/widgets/role_guard.dart';
import '../features/auth/models/user_model.dart';

import '../features/dashboard/receptionist_dashboard.dart';
import '../features/appointments/screens/appointment_booking_screen.dart';

class QueueArguments {
  final String doctorId;
  QueueArguments(this.doctorId);
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case AppRoutes.queue:
        // We can ignore args for now as ReceptionistDashboard shows global queue in this demo
        return MaterialPageRoute(
          builder: (_) => const RoleGuard(
            allowedRoles: [UserRole.receptionist, UserRole.admin],
            child: ReceptionistDashboard(),
          ),
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
        return MaterialPageRoute(
          builder: (_) => const RoleGuard(
            allowedRoles: [UserRole.doctor, UserRole.admin],
            child: DoctorViewScreen(),
          ),
        );
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case AppRoutes.widgetDemo:
        return MaterialPageRoute(
            builder: (_) => const WidgetRebuildDemoScreen());
      case AppRoutes.bookAppointment:
        return MaterialPageRoute(
          builder: (_) => const RoleGuard(
            allowedRoles: [UserRole.patient, UserRole.admin],
            child: AppointmentBookingScreen(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}
