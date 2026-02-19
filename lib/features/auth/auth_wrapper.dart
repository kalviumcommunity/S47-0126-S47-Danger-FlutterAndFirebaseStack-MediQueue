import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/auth_service.dart';
import 'providers/user_provider.dart';
import 'screens/login_screen.dart';
import '../dashboard/dashboard_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    
    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        // If waiting for auth state (initial check)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasData) {
          // User is authenticated with Firebase
          // Now check if UserProvider has loaded the profile
          return Consumer<UserProvider>(
            builder: (context, userProvider, _) {
              if (userProvider.isLoading) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              
              if (userProvider.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Error loading profile"),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              userProvider.refreshUser();
                            },
                            child: const Text("Retry"),
                          ),
                          TextButton(
                            onPressed: () {
                              authService.signOut();
                            },
                            child: const Text("Sign Out"),
                          )
                        ],
                      ),
                    ),
                  );
              }

              if (userProvider.user != null) {
                 return const DashboardScreen();
              }

              // Fallback loading state for brief transition
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        }
        
        return const LoginScreen();
      },
    );
  }
}
