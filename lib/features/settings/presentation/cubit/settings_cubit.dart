import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikr_app/core/usecases/usecase.dart';
import 'package:zikr_app/core/notifications/notification_service.dart';
import 'package:zikr_app/core/utils/app_logger.dart';
import '../../domain/usecases/settings_usecases.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetSettings getSettings;
  final ToggleDarkMode toggleDarkMode;
  final ChangeLanguage changeLanguage;
  final SetNotifications setNotifications;
  final SetMorningReminderTime setMorningReminderTime;
  final SetEveningReminderTime setEveningReminderTime;
  final NotificationService _notificationService;

  SettingsCubit({
    required this.getSettings,
    required this.toggleDarkMode,
    required this.changeLanguage,
    required this.setNotifications,
    required this.setMorningReminderTime,
    required this.setEveningReminderTime,
    NotificationService? notificationService,
  }) : _notificationService = notificationService ?? NotificationService(),
       super(const SettingsState());

  Future<void> loadSettings() async {
    emit(state.copyWith(status: SettingsStatus.loading));

    final result = await getSettings(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        status: SettingsStatus.error,
        message: failure.message,
      )),
      (settings) => emit(state.copyWith(
        status: SettingsStatus.loaded,
        settings: settings,
      )),
    );
  }

  Future<void> setDarkMode(bool isDark) async {
    await toggleDarkMode(isDark);
    emit(state.copyWith(
      settings: state.settings.copyWith(isDarkMode: isDark),
    ));
  }

  Future<void> setLanguage(String lang) async {
    await changeLanguage(lang);
    emit(state.copyWith(
      settings: state.settings.copyWith(language: lang),
    ));
  }

  Future<void> toggleNotifications(bool enabled) async {
    await setNotifications(enabled);

    if (enabled) {
      final permitted = await _notificationService.requestPermissions();
      if (!permitted) {
        logger.w('Notification permission denied', tag: 'SettingsCubit');
        return;
      }
    }

    emit(state.copyWith(
      settings: state.settings.copyWith(notificationsEnabled: enabled),
    ));

    await _notificationService.scheduleRemindersFromSettings(
      enabled: enabled,
      morningTime: state.settings.morningReminderTime,
      eveningTime: state.settings.eveningReminderTime,
    );
  }

  Future<void> updateMorningReminderTime(String time) async {
    await setMorningReminderTime(time);
    emit(state.copyWith(
      settings: state.settings.copyWith(morningReminderTime: time),
    ));

    if (state.settings.notificationsEnabled) {
      await _notificationService.scheduleRemindersFromSettings(
        enabled: true,
        morningTime: time,
        eveningTime: state.settings.eveningReminderTime,
      );
    }
  }

  Future<void> updateEveningReminderTime(String time) async {
    await setEveningReminderTime(time);
    emit(state.copyWith(
      settings: state.settings.copyWith(eveningReminderTime: time),
    ));

    if (state.settings.notificationsEnabled) {
      await _notificationService.scheduleRemindersFromSettings(
        enabled: true,
        morningTime: state.settings.morningReminderTime,
        eveningTime: time,
      );
    }
  }
}