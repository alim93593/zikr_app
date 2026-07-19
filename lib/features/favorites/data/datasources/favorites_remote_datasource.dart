import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zikr_app/features/favorites/data/models/favorites_model.dart';

abstract class FavoritesRemoteDataSource {
  Future<List<FavoritesModel>> getFavorites();
  Future<void> addFavorite(FavoritesModel favorite);
  Future<void> removeFavorite(String id);
  Future<bool> isFavorite(String id);
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  FavoritesRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });

  String? get _userId => firebaseAuth.currentUser?.uid;
  String get _favoritesCollection => 'users/$_userId/favorites';

  @override
  Future<List<FavoritesModel>> getFavorites() async {
    if (_userId == null) return [];
    try {
      final snap = await firestore.collection(_favoritesCollection).get();
      return snap.docs.map((doc) {
        final data = Map<String, dynamic>.from(doc.data());
        data['id'] = doc.id;
        return FavoritesModel.fromJson(data);
      }).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> addFavorite(FavoritesModel favorite) async {
    if (_userId == null) return;
    await firestore.collection(_favoritesCollection).doc(favorite.id).set(favorite.toJson());
  }

  @override
  Future<void> removeFavorite(String id) async {
    if (_userId == null) return;
    await firestore.collection(_favoritesCollection).doc(id).delete();
  }

  @override
  Future<bool> isFavorite(String id) async {
    if (_userId == null) return false;
    final doc = await firestore.collection(_favoritesCollection).doc(id).get();
    return doc.exists;
  }
}