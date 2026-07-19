import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../error/exceptions.dart';

/// Injectable wrapper around Firebase initialization and common operations.
class FirebaseService {
  FirebaseApp? _app;
  FirebaseAuth get auth => FirebaseAuth.instance;
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  FirebaseService();

  Future<FirebaseApp> init() async {
    _app = await Firebase.initializeApp();
    return _app!;
  }

  /// Read all documents from a collection. Each item will include its `id`.
  Future<List<Map<String, dynamic>>> getCollection(String collection) async {
    try {
      final snap = await firestore.collection(collection).get();
      return snap.docs.map((d) {
        final docMap = Map<String, dynamic>.from(d.data());
        docMap['id'] = d.id;
        return docMap;
      }).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// Read a single document by id
  Future<Map<String, dynamic>?> getDocument(
    String collection,
    String docId,
  ) async {
    try {
      final ref = firestore.collection(collection).doc(docId);
      final snap = await ref.get();
      if (!snap.exists) return null;
      final docMap = Map<String, dynamic>.from(
        snap.data() ?? <String, dynamic>{},
      );
      docMap['id'] = snap.id;
      return docMap;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// Create a document. If [docId] is provided the document will be created with that id; otherwise an ID will be auto-generated and returned.
  Future<String> createDocument(
    String collection,
    Map<String, dynamic> data, {
    String? docId,
  }) async {
    try {
      final colRef = firestore.collection(collection);
      if (docId != null) {
        await colRef.doc(docId).set(data);
        return docId;
      } else {
        final newDoc = await colRef.add(data);
        return newDoc.id;
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// Update a document by id
  Future<void> updateDocument(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) async {
    try {
      final ref = firestore.collection(collection).doc(docId);
      await ref.update(data);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// Delete a document by id
  Future<void> deleteDocument(String collection, String docId) async {
    try {
      final ref = firestore.collection(collection).doc(docId);
      await ref.delete();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // Example: sign out
  Future<void> signOut() async {
    await auth.signOut();
  }
}
