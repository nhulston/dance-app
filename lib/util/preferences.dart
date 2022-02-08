import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? prefs;
  static int _experienceLevel = -1;

  static init() async {
    if (prefs != null) return;

    prefs = await SharedPreferences.getInstance();
    _experienceLevel = prefs!.getInt('experienceLevel') ?? -1;
  }

  static resetPrefs() {
    prefs!.remove('experienceLevel');
    _experienceLevel = -1;
  }

  static void setExperienceLevel(int level) {
    // 0 = beginner, 1 = intermediate, 2 = advanced
    if (level < 0 || level > 2) {
      throw ArgumentError('Experience level must be in range 0-2');
    }

    _experienceLevel = level;
    prefs!.setInt('experienceLevel', level);
  }

  static int getExperienceLevel() {
    return _experienceLevel;
  }

  static String getExperienceLevelString() {
    if (_experienceLevel == 0) {
      return 'Beginner';
    } else if (_experienceLevel == 1) {
      return 'Intermediate';
    } else if (_experienceLevel == 2) {
      return 'Advanced';
    } else {
      return 'Unknown';
    }
  }
}