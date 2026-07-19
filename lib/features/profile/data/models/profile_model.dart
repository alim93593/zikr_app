import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.displayName,
    required super.email,
    super.photoUrl,
    super.totalTasbeehCount,
    super.currentStreak,
    super.longestStreak,
    super.favoritesCount,
    required super.joinedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json, String id) {
    DateTime? parsedDate;
    if (json['joinedAt'] != null) {
      if (json['joinedAt'] is Timestamp) {
        parsedDate = (json['joinedAt'] as Timestamp).toDate();
      } else if (json['joinedAt'] is String) {
        parsedDate = DateTime.tryParse(json['joinedAt'] as String);
      }
    }
    
    return ProfileModel(
      id: id,
      displayName: json['displayName'] as String? ?? 'مستخدم',
      email: json['email'] as String? ?? '',
      photoUrl: json['photoUrl'] as String?,
      totalTasbeehCount: json['totalTasbeehCount'] as int? ?? 0,
      currentStreak: json['currentStreak'] as int? ?? 0,
      longestStreak: json['longestStreak'] as int? ?? 0,
      favoritesCount: json['favoritesCount'] as int? ?? 0,
      joinedAt: parsedDate ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'totalTasbeehCount': totalTasbeehCount,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'favoritesCount': favoritesCount,
      'joinedAt': Timestamp.fromDate(joinedAt),
    };
  }
}