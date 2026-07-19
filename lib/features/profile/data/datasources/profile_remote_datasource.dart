import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zikr_app/features/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile(String userId);
  Future<void> updateProfile(String userId, Map<String, dynamic> data);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  ProfileRemoteDataSourceImpl({required this.firestore, required this.firebaseAuth});

  @override
  Future<ProfileModel> getProfile(String userId) async {
    final doc = await firestore.collection('users').doc(userId).get();
    if (!doc.exists) {
      final user = firebaseAuth.currentUser!;
      return ProfileModel(
        id: user.uid,
        displayName: user.displayName ?? 'مستخدم',
        email: user.email ?? '',
        photoUrl: user.photoURL,
        joinedAt: DateTime.now(),
      );
    }
    return ProfileModel.fromJson(doc.data()!, doc.id);
  }

  @override
  Future<void> updateProfile(String userId, Map<String, dynamic> data) async {
    await firestore.collection('users').doc(userId).update(data);
    if (data.containsKey('displayName')) {
      await firebaseAuth.currentUser?.updateDisplayName(data['displayName']);
    }
    if (data.containsKey('photoUrl')) {
      await firebaseAuth.currentUser?.updatePhotoURL(data['photoUrl']);
    }
  }
}