import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zikr_app/core/utils/app_logger.dart';
import 'package:zikr_app/features/zikir/data/models/zikir_category_model.dart';
import 'package:zikr_app/features/zikir/data/models/zikir_model.dart';

abstract class ZikirRemoteDataSource {
  Future<List<ZikirCategoryModel>> getCategories();
  Future<ZikirCategoryModel?> getCategoryByType(String type);
  Future<List<ZikirModel>> getZikirsByCategory(String categoryId);
  Future<ZikirModel?> getZikirById(String id);
  Future<void> saveFavorite(ZikirModel zikir);
  Future<void> removeFavorite(String zikirId);
  Future<List<String>> getUserFavorites();
  Future<List<ZikirModel>> getFavoriteZikirs();
}

class ZikirRemoteDataSourceImpl implements ZikirRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  ZikirRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });

  String? get _userId => firebaseAuth.currentUser?.uid;

  @override
  Future<List<ZikirCategoryModel>> getCategories() async {
    final userId = _userId;
    if (userId == null) return [];
    try {
      logger.i('getCategories from Firestore', tag: 'ZikirDataSource');
      final snap = await firestore.collection('users/$userId/categories').orderBy('order').get();
      logger.i('getCategories success', tag: 'ZikirDataSource', data: {'count': snap.docs.length});
      return snap.docs.map((doc) {
        final data = Map<String, dynamic>.from(doc.data());
        data['id'] = doc.id;
        return ZikirCategoryModel.fromJson(data);
      }).toList();
    } catch (e) {
      logger.e('getCategories error', tag: 'ZikirDataSource', data: e.toString());
      return [];
    }
  }

  @override
  Future<ZikirCategoryModel?> getCategoryByType(String type) async {
    final userId = _userId;
    if (userId == null) return null;
    try {
      logger.i('getCategoryByType', tag: 'ZikirDataSource', data: {'type': type});
      final snap = await firestore
          .collection('users/$userId/categories')
          .where('type', isEqualTo: type)
          .limit(1)
          .get();
      if (snap.docs.isNotEmpty) {
        final data = Map<String, dynamic>.from(snap.docs.first.data());
        data['id'] = snap.docs.first.id;
        return ZikirCategoryModel.fromJson(data);
      }

      final names = type == 'morning'
          ? ['أذكار الصباح', 'Morning Azkar', 'Morning', 'الصباح']
          : ['أذكار المساء', 'Evening Azkar', 'Evening', 'المساء'];
      for (final n in names) {
        for (final field in ['name', 'nameEn']) {
          final fallback = await firestore
              .collection('users/$userId/categories')
              .where(field, isEqualTo: n)
              .limit(1)
              .get();
          if (fallback.docs.isNotEmpty) {
            await fallback.docs.first.reference.update({'type': type});
            final data = Map<String, dynamic>.from(fallback.docs.first.data());
            data['id'] = fallback.docs.first.id;
            return ZikirCategoryModel.fromJson(data);
          }
        }
      }

      return null;
    } catch (e) {
      logger.e('getCategoryByType error', tag: 'ZikirDataSource', data: e.toString());
      return null;
    }
  }

  @override
  Future<List<ZikirModel>> getZikirsByCategory(String categoryId) async {
    final userId = _userId;
    if (userId == null) return [];
    try {
      logger.i('getZikrsByCategory', tag: 'ZikirDataSource', data: {'categoryId': categoryId});
      final snap = await firestore
          .collection('users/$userId/categories')
          .doc(categoryId)
          .collection('zikrs')
          .get();
      logger.i('getZikirsByCategory success', tag: 'ZikirDataSource', data: {'count': snap.docs.length});
      return snap.docs.map((doc) {
        final data = Map<String, dynamic>.from(doc.data());
        data['id'] = doc.id;
        data['categoryId'] = categoryId;
        return ZikirModel.fromJson(data);
      }).toList();
    } catch (e) {
      logger.e('getZikirsByCategory error', tag: 'ZikirDataSource', data: e.toString());
      return [];
    }
  }

  @override
  Future<ZikirModel?> getZikirById(String id) async {
    try {
      logger.i('getZikirById', tag: 'ZikirDataSource', data: {'id': id});
      final snap = await firestore.collection('zikrs').get();
      for (final doc in snap.docs) {
        if (doc.id == id) {
          final data = Map<String, dynamic>.from(doc.data());
          data['id'] = doc.id;
          return ZikirModel.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      logger.e('getZikirById error', tag: 'ZikirDataSource', data: e.toString());
      return null;
    }
  }

  @override
  Future<void> saveFavorite(ZikirModel zikir) async {
    final userId = _userId;
    if (userId == null) return;
    logger.i('saveFavorite', tag: 'ZikirDataSource', data: {'userId': userId, 'id': zikir.id});
    await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(zikir.id)
        .set({
      ...zikir.toJson(),
      'savedAt': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<void> removeFavorite(String zikirId) async {
    final userId = _userId;
    if (userId == null) return;
    logger.i('removeFavorite', tag: 'ZikirDataSource', data: {'userId': userId, 'zikirId': zikirId});
    await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(zikirId)
        .delete();
  }

  @override
  Future<List<String>> getUserFavorites() async {
    final userId = _userId;
    if (userId == null) return [];
    try {
      logger.i('getUserFavorites', tag: 'ZikirDataSource', data: {'userId': userId});
      final snap = await firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .get();
      return snap.docs.map((doc) => doc.id).toList();
    } catch (e) {
      logger.e('getUserFavorites error', tag: 'ZikirDataSource', data: e.toString());
      return [];
    }
  }

  @override
  Future<List<ZikirModel>> getFavoriteZikirs() async {
    final userId = _userId;
    if (userId == null) return [];
    try {
      logger.i('getFavoriteZikirs', tag: 'ZikirDataSource', data: {'userId': userId});
      final snap = await firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .get();
      final zikirs = <ZikirModel>[];
      for (final doc in snap.docs) {
        final data = Map<String, dynamic>.from(doc.data());
        data['id'] = doc.id;
        data['isFavorite'] = true;
        try {
          final zikir = ZikirModel.fromJson(data);
          zikirs.add(zikir);
          if (data['text'] == null && data['title'] != null) {
            await firestore
                .collection('users')
                .doc(userId)
                .collection('favorites')
                .doc(doc.id)
                .update(zikir.toJson());
          }
        } catch (e) {
          logger.e('getFavoriteZikirs parse error for doc ${doc.id}', tag: 'ZikirDataSource', data: e.toString());
          continue;
        }
      }
      logger.i('getFavoriteZikirs success', tag: 'ZikirDataSource', data: {'count': zikirs.length});
      return zikirs;
    } catch (e) {
      logger.e('getFavoriteZikirs error', tag: 'ZikirDataSource', data: e.toString());
      return [];
    }
  }
}