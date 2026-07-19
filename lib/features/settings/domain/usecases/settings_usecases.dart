import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import 'package:zikr_app/core/usecases/usecase.dart';
import '../entities/settings_entity.dart';
import '../repositories/settings_repository.dart';

class GetSettings extends UseCase<SettingsEntity, NoParams> {
  final SettingsRepository repository;
  GetSettings(this.repository);

  @override
  Future<Either<Failure, SettingsEntity>> call(NoParams params) {
    return repository.getSettings();
  }
}

class SaveSettingsItem extends UseCase<void, SettingsEntity> {
  final SettingsRepository repository;
  SaveSettingsItem(this.repository);

  @override
  Future<Either<Failure, void>> call(SettingsEntity params) {
    return repository.saveSettings(params);
  }
}

class ToggleDarkMode extends UseCase<void, bool> {
  final SettingsRepository repository;
  ToggleDarkMode(this.repository);

  @override
  Future<Either<Failure, void>> call(bool params) {
    return repository.setDarkMode(params);
  }
}

class ChangeLanguage extends UseCase<void, String> {
  final SettingsRepository repository;
  ChangeLanguage(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) {
    return repository.setLanguage(params);
  }
}

class SetNotifications extends UseCase<void, bool> {
  final SettingsRepository repository;
  SetNotifications(this.repository);

  @override
  Future<Either<Failure, void>> call(bool params) {
    return repository.setNotifications(params);
  }
}

class SetMorningReminderTime extends UseCase<void, String> {
  final SettingsRepository repository;
  SetMorningReminderTime(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) {
    return repository.setMorningReminderTime(params);
  }
}

class SetEveningReminderTime extends UseCase<void, String> {
  final SettingsRepository repository;
  SetEveningReminderTime(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) {
    return repository.setEveningReminderTime(params);
  }
}