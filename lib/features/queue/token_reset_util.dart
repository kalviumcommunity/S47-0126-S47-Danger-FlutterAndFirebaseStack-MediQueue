import 'package:shared_preferences/shared_preferences.dart';
import 'token_generator.dart';

Future<void> checkAndResetTokens() async {
  final prefs = await SharedPreferences.getInstance();
  final lastReset = prefs.getString('last_token_reset');
  final today = DateTime.now().toIso8601String().substring(0, 10);
  if (lastReset != today) {
    await TokenGenerator.resetCounters();
    await prefs.setString('last_token_reset', today);
  }
}