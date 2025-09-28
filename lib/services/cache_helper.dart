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
  // static Future<void> cacheLanguage(String code) async {
  //   await prefsWithCache.setString(SharedKeys.langCode.name, code);
  // }

  static Future<void> cacheThemeMode(bool mode) async {
    await prefsWithCache.setBool('themeMode', mode);
  }

  ///Getters
  // static String getLanguageCode() {
  //   final code = prefsWithCache.getString(SharedKeys.langCode.name);
  //   return code ?? 'en';
  // }

  static bool getThemeMode() {
    //return true if dark mode
    final mode = prefsWithCache.getBool('themeMode');
    return mode ?? false;
  }
}
