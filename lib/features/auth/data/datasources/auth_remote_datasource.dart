import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zikr_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmail(String email, String password);
  Future<UserModel> signUpWithEmail(String email, String password, String displayName);
  Future<void> signOut();
  UserModel? getCurrentUser();
  Stream<UserModel?> authStateChanges();
  Future<void> updateUserData(String userId, Map<String, dynamic> data);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> signInWithEmail(String email, String password) async {
    final result = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebaseUser(result.user);
  }

  @override
  Future<UserModel> signUpWithEmail(String email, String password, String displayName) async {
    final result = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final userId = result.user!.uid;

    await _createUserDocument(userId, email, displayName);

    await result.user?.updateDisplayName(displayName);
    return UserModel.fromFirebaseUser(result.user);
  }

  Future<void> _createUserDocument(String userId, String email, String displayName) async {
    await firestore.collection('users').doc(userId).set({
      'id': userId,
      'email': email,
      'displayName': displayName,
      'photoUrl': null,
      'totalTasbeehCount': 0,
      'currentStreak': 0,
      'longestStreak': 0,
      'favoritesCount': 0,
      'joinedAt': FieldValue.serverTimestamp(),
      'lastActiveAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  UserModel? getCurrentUser() {
    final user = firebaseAuth.currentUser;
    if (user == null) return null;
    return UserModel.fromFirebaseUser(user);
  }

  @override
  Stream<UserModel?> authStateChanges() {
    return firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return UserModel.fromFirebaseUser(user);
    });
  }

  @override
  Future<void> updateUserData(String userId, Map<String, dynamic> data) async {
    await firestore.collection('users').doc(userId).update(data);
    if (data.containsKey('displayName')) {
      await firebaseAuth.currentUser?.updateDisplayName(data['displayName']);
    }
    if (data.containsKey('photoUrl')) {
      await firebaseAuth.currentUser?.updatePhotoURL(data['photoUrl']);
    }
  }
}
