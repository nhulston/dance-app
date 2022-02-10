import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

/// Handles data stored on the local device
class Preferences {
  static SharedPreferences? prefs;
  static int _experienceLevel = -1;

  /// Called on start up
  /// Initializes the prefs variable so we don't have to keep re-instantiating
  /// Also sets all the variables
  static init() async {
    if (prefs != null) return;

    log('[Prefs init] Initializing preferences');
    prefs = await SharedPreferences.getInstance();
    _experienceLevel = prefs!.getInt('experienceLevel') ?? -1;
  }

  /// Called when logging out
  /// Removes all prefs stored on device and resets all variables
  static resetPrefs() {
    log('[Prefs resetPrefs] Removing all preferences & reset variables');
    prefs!.remove('experienceLevel');
    _experienceLevel = -1;
  }

  /// Called when logging in and whenever experience level is changed
  /// Sets experience level on prefs and the variables
  static void setExperienceLevel(int level) {
    // 0 = beginner, 1 = intermediate, 2 = advanced
    if (level < 0 || level > 2) {
      throw ArgumentError('Experience level must be in range 0-2');
    }

    log('[Prefs setExperienceLevel] Setting experience level locally to $level');
    _experienceLevel = level;
    prefs!.setInt('experienceLevel', level);
  }

  /// Returns the get experience variable
  static int getExperienceLevel() {
    return _experienceLevel;
  }

  /// Returns the experience level as a string
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