import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../services/database_helper.dart';
import '../models/sync_item.dart';

class SyncService extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  bool _isOnline = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  bool get isOnline => _isOnline;

  SyncService() {
    _initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      debugPrint('Couldn\'t check connectivity status: $e');
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    // In connectivity_plus > 5.0.0, the result is a List<ConnectivityResult>
    bool isConnected = result.any((r) => r != ConnectivityResult.none);

    if (_isOnline != isConnected) {
      _isOnline = isConnected;
      notifyListeners();
      debugPrint(
          'Connection status changed: ${_isOnline ? "Online" : "Offline"}');

      if (_isOnline) {
        _performSync();
      }
    }
  }

  /// Queues an action to be executed. If online, executes immediately.
  /// If offline, saves to local database for later sync.
  Future<void> queueAction(String action, Map<String, dynamic> data) async {
    final syncItem = SyncItem(
      id: null,
      action: action,
      data: jsonEncode(data),
      timestamp: DateTime.now().toIso8601String(),
    );

    if (_isOnline) {
      await _executeAction(syncItem);
    } else {
      await _databaseHelper.insertSyncItem(syncItem);
      debugPrint('Queued offline action: $action');
    }
  }

  Future<void> _performSync() async {
    debugPrint('Performing sync...');
    final pendingItems = await _databaseHelper.getSyncItems();

    if (pendingItems.isEmpty) {
      debugPrint('No pending items to sync.');
      return;
    }

    for (var item in pendingItems) {
      try {
        await _executeAction(item);
        if (item.id != null) {
          await _databaseHelper.deleteSyncItem(item.id!);
        }
      } catch (e) {
        debugPrint('Failed to sync item ${item.id}: $e');
        // Optionally implement retry logic or move to a failed queue
      }
    }
    debugPrint('Sync complete.');
  }

  Future<void> _executeAction(SyncItem item) async {
    // Simulate API call or Firestore interaction based on 'action'
    debugPrint('Executing action: ${item.action} with data: ${item.data}');
    await Future.delayed(const Duration(seconds: 1)); // Simulate network request

    // Here you would check item.action and call appropriate service methods
    // switch (item.action) {
    //   case 'update_profile':
    //     await firestoreService.updateProfile(...);
    //     break;
    // }
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}
