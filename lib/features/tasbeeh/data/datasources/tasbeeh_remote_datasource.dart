import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class TasbeehRemoteDataSource {
  Future<void> saveStats({required int totalCount, required int streakDays});
  Future<Map<String, dynamic>> getStats();
}

class TasbeehRemoteDataSourceImpl implements TasbeehRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  TasbeehRemoteDataSourceImpl({required this.firestore, required this.firebaseAuth});

  String get _userPath {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');
    return 'users/$uid';
  }

  @override
  Future<void> saveStats({required int totalCount, required int streakDays}) async {
    await firestore.doc(_userPath).set({
      'totalTasbeehCount': totalCount,
      'currentStreak': streakDays,
      'lastUpdated': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  @override
  Future<Map<String, dynamic>> getStats() async {
    final doc = await firestore.doc(_userPath).get();
    if (doc.exists) {
      return {
        'totalCount': doc.data()?['totalTasbeehCount'] ?? 0,
        'streakDays': doc.data()?['currentStreak'] ?? 0,
      };
    }
    return {'totalCount': 0, 'streakDays': 0};
  }
}
