import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'services/firestore_service.dart';
import 'services/notification_service.dart';
import 'features/auth/services/auth_service.dart';
import 'features/auth/providers/user_provider.dart';
import 'services/sync_service.dart';
import 'features/queue/queue_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (assumes native configuration exists or fails gracefully)
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }

  // Instantiate services that don't depend on other providers
  final authService = AuthService();
  final firestoreService = FirestoreService();
  final queueRepository = QueueRepository();
  final notificationService = NotificationService();
  await notificationService.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>.value(
          value: authService,
        ),
        Provider<FirestoreService>.value(
          value: firestoreService,
        ),
        Provider<QueueRepository>.value(
          value: queueRepository,
        ),
        Provider<NotificationService>.value(
          value: notificationService,
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (_) =>
              UserProvider(authService, firestoreService, notificationService),
        ),
        ChangeNotifierProvider<SyncService>(
          create: (_) => SyncService(),
        ),
      ],
      child: const MediQueueApp(),
    ),
  );
}
