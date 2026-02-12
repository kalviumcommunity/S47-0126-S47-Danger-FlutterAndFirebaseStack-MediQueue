import 'package:flutter/foundation.dart';

class AppConfig {
  static const String appName = 'MediQueue';
  static const String apiBaseUrl = 'https://api.mediqueue.com';
  static const bool enableLogging = kDebugMode;
  static const int queueRefreshInterval = 2; // seconds
  static const String databaseName = 'mediqueue.db';
  static const int databaseVersion = 1;
  // Add more config values as needed
}
