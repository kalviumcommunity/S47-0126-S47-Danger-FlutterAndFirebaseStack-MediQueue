import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/user_model.dart';
import '../screens/login_screen.dart';

class RoleGuard extends StatelessWidget {
  final Widget child;
  final List<UserRole> allowedRoles;

  const RoleGuard({
    Key? key,
    required this.child,
    required this.allowedRoles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        if (userProvider.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!userProvider.isAuthenticated) {
          return const LoginScreen();
        }

        final user = userProvider.user;

        // If user is null but authenticated (profile fetch failure), perhaps allow retry or show error
        if (user == null) {
             return const Scaffold(
                body: Center(child: Text("Error loading user profile")),
             );
        }

        if (allowedRoles.isNotEmpty && !allowedRoles.contains(user.role)) {
            return Scaffold(
              appBar: AppBar(title: const Text("Access Denied")),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_person, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Access Restricted',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text('You do not have permission to view this page.'),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to dashboard which should be accessible
                        Navigator.of(context).pushReplacementNamed('/dashboard');
                      },
                      child: const Text('Go to Dashboard'),
                    ),
                  ],
                ),
              ),
            );
        }
        
        return child;
      },
     );
  }
}
