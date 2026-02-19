import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class SyncService extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  bool _isOnline = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  bool get isOnline => _isOnline;

  SyncService() {
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
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
      debugPrint('Connection status changed: ${_isOnline ? "Online" : "Offline"}');
      
      if (_isOnline) {
        _performSync();
      }
    }
  }

  Future<void> _performSync() async {
    // Firestore handles most sync automatically.
    // This method is for any manual sync logic if needed,
    // e.g., syncing local preferences or other non-firestore data.
    debugPrint('Performing sync...');
    await Future.delayed(const Duration(seconds: 1)); // Simulate sync
    debugPrint('Sync complete.');
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}
