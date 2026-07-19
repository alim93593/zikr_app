import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final DateTime createdAt;
  final int totalTasbeehCount;
  final int streakDays;
  final String preferredLanguage;

  const UserEntity({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    required this.createdAt,
    this.totalTasbeehCount = 0,
    this.streakDays = 0,
    this.preferredLanguage = 'ar',
  });

  UserEntity copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    DateTime? createdAt,
    int? totalTasbeehCount,
    int? streakDays,
    String? preferredLanguage,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      totalTasbeehCount: totalTasbeehCount ?? this.totalTasbeehCount,
      streakDays: streakDays ?? this.streakDays,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
    );
  }

  @override
  List<Object?> get props => [id, email, displayName, photoUrl, createdAt, totalTasbeehCount, streakDays, preferredLanguage];
}