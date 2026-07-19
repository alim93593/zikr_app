import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String displayName;
  final String email;
  final String? photoUrl;
  final int totalTasbeehCount;
  final int currentStreak;
  final int longestStreak;
  final int favoritesCount;
  final DateTime joinedAt;

  const ProfileEntity({
    required this.id,
    required this.displayName,
    required this.email,
    this.photoUrl,
    this.totalTasbeehCount = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.favoritesCount = 0,
    required this.joinedAt,
  });

  ProfileEntity copyWith({
    String? id,
    String? displayName,
    String? email,
    String? photoUrl,
    int? totalTasbeehCount,
    int? currentStreak,
    int? longestStreak,
    int? favoritesCount,
    DateTime? joinedAt,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      totalTasbeehCount: totalTasbeehCount ?? this.totalTasbeehCount,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      favoritesCount: favoritesCount ?? this.favoritesCount,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }

  @override
  List<Object?> get props => [id, displayName, email, photoUrl, totalTasbeehCount, currentStreak, longestStreak, favoritesCount, joinedAt];
}