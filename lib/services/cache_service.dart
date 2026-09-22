import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
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

  static Future<void> cacheLocation(double lat, double lng, String city) async {
    await prefsWithCache.setDouble('user_lat', lat);
    await prefsWithCache.setDouble('user_lng', lng);
    await prefsWithCache.setString('user_city', city);
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

  static Map<String, dynamic>? getCachedLocation() {
    final lat = prefsWithCache.getDouble('user_lat');
    final lng = prefsWithCache.getDouble('user_lng');
    final city = prefsWithCache.getString('user_city');

    if (lat != null && lng != null && city != null) {
      return {'lat': lat, 'lng': lng, 'city': city};
    }
    return null;
  }
}
