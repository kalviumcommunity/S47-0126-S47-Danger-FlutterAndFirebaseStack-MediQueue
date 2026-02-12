import 'package:shared_preferences/shared_preferences.dart';

class TokenGenerator {
  static const String _defaultPrefix = 'A';
  static final Map<String, int> _counters = {};
  static String _lastResetDate = '';

  static Future<void> _checkAndResetCounters() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);
    _lastResetDate = prefs.getString('last_token_reset') ?? '';
    if (_lastResetDate != today) {
      _counters.clear();
      await prefs.setString('last_token_reset', today);
      _lastResetDate = today;
    }
  }

  static Future<String> generateToken({String? department}) async {
    await _checkAndResetCounters();
    final prefix = (department?.substring(0, 1).toUpperCase() ?? _defaultPrefix);
    _counters[prefix] = (_counters[prefix] ?? 0) + 1;
    return '$prefix-${_counters[prefix]!.toString().padLeft(3, '0')}';
  }

  static Future<void> resetCounters() async {
    _counters.clear();
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);
    await prefs.setString('last_token_reset', today);
    _lastResetDate = today;
  }

  static String getCurrentToken(String department) {
    final prefix = department.substring(0, 1).toUpperCase();
    final count = _counters[prefix] ?? 0;
    return '$prefix-${count.toString().padLeft(3, '0')}';
  }
}
