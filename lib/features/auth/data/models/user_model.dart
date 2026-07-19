import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.displayName,
    super.photoUrl,
    required super.createdAt,
    super.totalTasbeehCount,
    super.streakDays,
    super.preferredLanguage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    DateTime createdAt;
    try {
      final createdAtValue = json['createdAt'];
      if (createdAtValue is Timestamp) {
        createdAt = createdAtValue.toDate();
      } else if (createdAtValue is String) {
        createdAt = DateTime.parse(createdAtValue);
      } else {
        createdAt = DateTime.now();
      }
    } catch (_) {
      createdAt = DateTime.now();
    }

    return UserModel(
      id: id,
      email: json['email'] as String? ?? '',
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      createdAt: createdAt,
      totalTasbeehCount: json['totalTasbeehCount'] as int? ?? 0,
      streakDays: json['streakDays'] as int? ?? 0,
      preferredLanguage: json['preferredLanguage'] as String? ?? 'ar',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'createdAt': createdAt.toIso8601String(),
      'totalTasbeehCount': totalTasbeehCount,
      'streakDays': streakDays,
      'preferredLanguage': preferredLanguage,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      displayName: entity.displayName,
      photoUrl: entity.photoUrl,
      createdAt: entity.createdAt,
      totalTasbeehCount: entity.totalTasbeehCount,
      streakDays: entity.streakDays,
      preferredLanguage: entity.preferredLanguage,
    );
  }

  factory UserModel.fromFirebaseUser(dynamic firebaseUser) {
    return UserModel(
      id: firebaseUser.uid as String,
      email: firebaseUser.email as String? ?? '',
      displayName: firebaseUser.displayName as String?,
      photoUrl: firebaseUser.photoURL as String?,
      createdAt: DateTime.now(),
    );
  }
}
