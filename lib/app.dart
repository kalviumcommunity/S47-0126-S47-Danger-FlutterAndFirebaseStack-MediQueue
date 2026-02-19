import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
// import 'routes/app_routes.dart'; // Unused
import 'routes/route_generator.dart';
import 'core/app_globals.dart';
import 'features/auth/auth_wrapper.dart';
import 'services/sync_service.dart';
import 'widgets/offline_wrapper.dart';

class MediQueueApp extends StatelessWidget {
  const MediQueueApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediQueue',
      navigatorKey: navigatorKey,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const AuthWrapper(),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return OfflineWrapper(child: child);
      },
    );
  }
}
