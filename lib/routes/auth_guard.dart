import '../features/auth/services/auth_service.dart';
import 'app_routes.dart';

class AuthGuard {
  static bool canActivate(String route) {
    final isAuthenticated = AuthService.isLoggedIn();
    if (!isAuthenticated && route != AppRoutes.login) {
      return false;
    }
    return true;
  }
}
