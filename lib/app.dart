import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_routes.dart';

class MediQueueApp extends StatelessWidget {
  const MediQueueApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediQueue',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routes: appRoutes,
      initialRoute: '/',
    );
  }
}
