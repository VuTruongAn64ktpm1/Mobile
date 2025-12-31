import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  static const _key = 'seen_onboarding';

  static Future<bool> hasSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  static Future<void> markSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }
}
