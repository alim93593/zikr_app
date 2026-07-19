import 'package:equatable/equatable.dart';

class SettingsEntity extends Equatable {
  final bool isDarkMode;
  final String language;
  final bool notificationsEnabled;
  final String morningReminderTime;
  final String eveningReminderTime;
  final double fontSize;

  const SettingsEntity({
    this.isDarkMode = false,
    this.language = 'ar',
    this.notificationsEnabled = true,
    this.morningReminderTime = '06:00',
    this.eveningReminderTime = '18:00',
    this.fontSize = 1.0,
  });

  SettingsEntity copyWith({
    bool? isDarkMode,
    String? language,
    bool? notificationsEnabled,
    String? morningReminderTime,
    String? eveningReminderTime,
    double? fontSize,
  }) {
    return SettingsEntity(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      morningReminderTime: morningReminderTime ?? this.morningReminderTime,
      eveningReminderTime: eveningReminderTime ?? this.eveningReminderTime,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  @override
  List<Object?> get props => [
        isDarkMode,
        language,
        notificationsEnabled,
        morningReminderTime,
        eveningReminderTime,
        fontSize,
      ];
}