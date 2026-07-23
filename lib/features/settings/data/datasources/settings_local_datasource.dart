import 'package:shared_preferences/shared_preferences.dart';
import 'package:zikr_app/features/settings/data/models/settings_model.dart';

abstract class SettingsLocalDataSource {
  Future<SettingsModel> getSettings();
  Future<void> saveSettings(SettingsModel settings);
  Future<void> setDarkMode(bool isDark);
  Future<void> setLanguage(String lang);
  Future<void> setNotifications(bool enabled);
  Future<void> setMorningReminderTime(String time);
  Future<void> setEveningReminderTime(String time);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _darkModeKey = 'dark_mode';
  static const String _langKey = 'app_language';
  static const String _notifKey = 'notifications_enabled';
  static const String _morningKey = 'morning_time';
  static const String _eveningKey = 'evening_time';
  static const String _fontSizeKey = 'font_size';

  SettingsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<SettingsModel> getSettings() async {
    final isDark = sharedPreferences.getBool(_darkModeKey) ?? false;
    final lang = sharedPreferences.getString(_langKey) ?? 'ar';
    final notif = sharedPreferences.getBool(_notifKey) ?? true;
    final morning = sharedPreferences.getString(_morningKey) ?? '06:00';
    final evening = sharedPreferences.getString(_eveningKey) ?? '18:00';
    final fontSize = sharedPreferences.getDouble(_fontSizeKey) ?? 1.0;

    return SettingsModel(
      isDarkMode: isDark,
      language: lang,
      notificationsEnabled: notif,
      morningReminderTime: morning,
      eveningReminderTime: evening,
      fontSize: fontSize,
    );
  }

  @override
  Future<void> saveSettings(SettingsModel settings) async {
    await sharedPreferences.setBool(_darkModeKey, settings.isDarkMode);
    await sharedPreferences.setString(_langKey, settings.language);
    await sharedPreferences.setBool(_notifKey, settings.notificationsEnabled);
    await sharedPreferences.setString(
      _morningKey,
      settings.morningReminderTime,
    );
    await sharedPreferences.setString(
      _eveningKey,
      settings.eveningReminderTime,
    );
    await sharedPreferences.setDouble(_fontSizeKey, settings.fontSize);
  }

  @override
  Future<void> setDarkMode(bool isDark) async {
    await sharedPreferences.setBool(_darkModeKey, isDark);
  }

  @override
  Future<void> setLanguage(String lang) async {
    await sharedPreferences.setString(_langKey, lang);
  }

  @override
  Future<void> setNotifications(bool enabled) async {
    await sharedPreferences.setBool(_notifKey, enabled);
  }

  @override
  Future<void> setMorningReminderTime(String time) async {
    await sharedPreferences.setString(_morningKey, time);
  }

  @override
  Future<void> setEveningReminderTime(String time) async {
    await sharedPreferences.setString(_eveningKey, time);
  }
}
