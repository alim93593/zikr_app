import 'package:equatable/equatable.dart';
import '../../domain/entities/settings_entity.dart';

enum SettingsStatus { initial, loading, loaded, error }

class SettingsState extends Equatable {
  final SettingsStatus status;
  final SettingsEntity settings;
  final int totalCount;
  final int streakDays;
  final String? message;

  const SettingsState({
    this.status = SettingsStatus.initial,
    this.settings = const SettingsEntity(),
    this.totalCount = 0,
    this.streakDays = 0,
    this.message,
  });

  SettingsState copyWith({
    SettingsStatus? status,
    SettingsEntity? settings,
    int? totalCount,
    int? streakDays,
    String? message,
  }) {
    return SettingsState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
      totalCount: totalCount ?? this.totalCount,
      streakDays: streakDays ?? this.streakDays,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, settings, totalCount, streakDays, message];
}