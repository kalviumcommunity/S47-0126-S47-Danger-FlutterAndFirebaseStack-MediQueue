import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/sync_service.dart';

class OfflineWrapper extends StatelessWidget {
  final Widget? child;

  const OfflineWrapper({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (child != null) child!,
        Consumer<SyncService>(
          builder: (context, syncService, _) {
            if (syncService.isOnline) {
              return const SizedBox.shrink();
            }
            return const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Material(
                color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wifi_off, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'You are offline. Changes will be synced later.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
