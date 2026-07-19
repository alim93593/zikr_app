import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zikr_app/core/error/failures.dart';
import '../../domain/entities/settings_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';
import '../models/settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, SettingsEntity>> getSettings() async {
    try {
      final settings = await localDataSource.getSettings();
      return Right(settings);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveSettings(SettingsEntity settings) async {
    try {
      await localDataSource.saveSettings(SettingsModel.fromEntity(settings));
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setDarkMode(bool isDark) async {
    try {
      await localDataSource.setDarkMode(isDark);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setLanguage(String lang) async {
    try {
      await localDataSource.setLanguage(lang);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setNotifications(bool enabled) async {
    try {
      await localDataSource.setNotifications(enabled);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setMorningReminderTime(String time) async {
    try {
      await localDataSource.setMorningReminderTime(time);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setEveningReminderTime(String time) async {
    try {
      await localDataSource.setEveningReminderTime(time);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}