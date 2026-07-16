import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferencesWithCache prefsWithCache;

  static Future<void> init() async {
    prefsWithCache = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
  }

  static Future<void> clear() async {
    await prefsWithCache.clear();
  }

  ///Setters
  static Future<void> cacheAzkarCount(int count) async {
    await prefsWithCache.setInt('azkarCount', count);
  }

  static Future<void> cacheThemeMode(bool mode) async {
    await prefsWithCache.setBool('themeMode', mode);
  }

  ///Getters
  static int getAzkarCount() {
    final count = prefsWithCache.getInt('azkarCount');
    return count ?? 0;
  }

  static bool getThemeMode() {
    //return true if dark mode
    final mode = prefsWithCache.getBool('themeMode');
    return mode ?? false;
  }
}
