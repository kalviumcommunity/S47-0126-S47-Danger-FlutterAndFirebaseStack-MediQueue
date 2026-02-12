import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/dashboard/widget_rebuild_demo_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const LoginScreen(),
  '/dashboard': (context) => const DashboardScreen(),
  '/widget-demo': (context) => const WidgetRebuildDemoScreen(),
};
