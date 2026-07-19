import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ZikirManagementState {}

class ZikirManagementInitial extends ZikirManagementState {}

class ZikirManagementLoading extends ZikirManagementState {}

class ZikirManagementLoaded extends ZikirManagementState {}

class ZikirManagementError extends ZikirManagementState {
  final String message;
  ZikirManagementError(this.message);
}

class ZikirManagementCubit extends Cubit<ZikirManagementState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _userId => _auth.currentUser?.uid ?? '';
  String get _userCollectionPath => 'users/$_userId/categories';

  ZikirManagementCubit() : super(ZikirManagementInitial());

  Future<void> addCategory({
    required String name,
    required String nameEn,
    required String description,
    required String icon,
    required int color,
  }) async {
    if (_userId.isEmpty) {
      emit(ZikirManagementError('غير مسجل'));
      return;
    }
    emit(ZikirManagementLoading());
    try {
      await _firestore.collection(_userCollectionPath).add({
        'name': name,
        'nameEn': nameEn,
        'description': description,
        'icon': icon,
        'color': color,
        'order': DateTime.now().millisecondsSinceEpoch,
        'createdAt': FieldValue.serverTimestamp(),
      });
      emit(ZikirManagementLoaded());
    } catch (e) {
      emit(ZikirManagementError(e.toString()));
    }
  }

  Future<void> updateCategory({
    required String categoryId,
    required String name,
    required String nameEn,
    required String description,
  }) async {
    if (_userId.isEmpty) return;
    try {
      await _firestore.collection(_userCollectionPath).doc(categoryId).update({
        'name': name,
        'nameEn': nameEn,
        'description': description,
      });
      emit(ZikirManagementLoaded());
    } catch (e) {
      emit(ZikirManagementError(e.toString()));
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    if (_userId.isEmpty) return;
    try {
      await _firestore.collection(_userCollectionPath).doc(categoryId).delete();
      emit(ZikirManagementLoaded());
    } catch (e) {
      emit(ZikirManagementError(e.toString()));
    }
  }

  Future<void> addZikir({
    required String categoryId,
    required String text,
    required int count,
    required String source,
    required int color,
  }) async {
    if (_userId.isEmpty) return;
    try {
      await _firestore.collection(_userCollectionPath).doc(categoryId).collection('zikrs').add({
        'text': text,
        'count': count,
        'source': source,
        'color': color,
        'createdAt': FieldValue.serverTimestamp(),
      });
      emit(ZikirManagementLoaded());
    } catch (e) {
      emit(ZikirManagementError(e.toString()));
    }
  }

  Future<void> updateZikir({
    required String categoryId,
    required String zikirId,
    required String text,
    required int count,
    required String source,
    required int color,
  }) async {
    if (_userId.isEmpty) return;
    try {
      await _firestore.collection(_userCollectionPath).doc(categoryId).collection('zikrs').doc(zikirId).update({
        'text': text,
        'count': count,
        'source': source,
        'color': color,
      });
      emit(ZikirManagementLoaded());
    } catch (e) {
      emit(ZikirManagementError(e.toString()));
    }
  }

  Future<void> deleteZikir(String categoryId, String zikirId) async {
    if (_userId.isEmpty) return;
    try {
      await _firestore.collection(_userCollectionPath).doc(categoryId).collection('zikrs').doc(zikirId).delete();
      emit(ZikirManagementLoaded());
    } catch (e) {
      emit(ZikirManagementError(e.toString()));
    }
  }
}