import 'package:shared_preferences/shared_preferences.dart';

class AppConfigRepository {
  static const String _darkModeKey = 'dark_mode';

  SharedPreferences? _prefs;
  bool _isDarkMode = false;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode = _prefs?.getBool(_darkModeKey) ?? false;
  }

  bool get isDarkMode => _isDarkMode;

  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    await _prefs?.setBool(_darkModeKey, value);
  }

  Stream<bool> observeDarkMode() async* {
    yield _isDarkMode;
  }
}
