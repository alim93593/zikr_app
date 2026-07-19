import '../../domain/entities/settings_entity.dart';

class SettingsModel extends SettingsEntity {
  const SettingsModel({
    super.isDarkMode,
    super.language,
    super.notificationsEnabled,
    super.morningReminderTime,
    super.eveningReminderTime,
    super.fontSize,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      isDarkMode: json['isDarkMode'] as bool? ?? false,
      language: json['language'] as String? ?? 'ar',
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      morningReminderTime: json['morningReminderTime'] as String? ?? '06:00',
      eveningReminderTime: json['eveningReminderTime'] as String? ?? '18:00',
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 1.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'language': language,
      'notificationsEnabled': notificationsEnabled,
      'morningReminderTime': morningReminderTime,
      'eveningReminderTime': eveningReminderTime,
      'fontSize': fontSize,
    };
  }

  factory SettingsModel.fromEntity(SettingsEntity entity) {
    return SettingsModel(
      isDarkMode: entity.isDarkMode,
      language: entity.language,
      notificationsEnabled: entity.notificationsEnabled,
      morningReminderTime: entity.morningReminderTime,
      eveningReminderTime: entity.eveningReminderTime,
      fontSize: entity.fontSize,
    );
  }
}