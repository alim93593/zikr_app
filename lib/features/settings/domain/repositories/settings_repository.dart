import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import '../entities/settings_entity.dart';

abstract class SettingsRepository {
  Future<Either<Failure, SettingsEntity>> getSettings();
  Future<Either<Failure, void>> saveSettings(SettingsEntity settings);
  Future<Either<Failure, void>> setDarkMode(bool isDark);
  Future<Either<Failure, void>> setLanguage(String lang);
  Future<Either<Failure, void>> setNotifications(bool enabled);
  Future<Either<Failure, void>> setMorningReminderTime(String time);
  Future<Either<Failure, void>> setEveningReminderTime(String time);
}