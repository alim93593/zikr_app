import 'package:zikr_app/core/firebase/firebase_service.dart';
import 'package:zikr_app/core/utils/constants.dart';

import '../../data/models/collection_model.dart';

/// Remote datasource backed by Firestore via FirebaseService.
/// This datasource supports both a global collection and per-user subcollections.
class HomeRemoteDataSource {
  final FirebaseService firebaseService;
  HomeRemoteDataSource({required this.firebaseService});

  /// Fetch collections for a specific user (if [userId] provided) or global collections otherwise.
  Future<List<CollectionModel>> fetchCollections({String? userId}) async {
    final collectionPath = userId == null
        ? Constants.globalCollections
        : '${Constants.usersCollection}/$userId/${Constants.collectionsSub}';

    final raw = await firebaseService.getCollection(collectionPath);
    return raw.map((e) => CollectionModel.fromJson(e)).toList();
  }

  /// Create a collection document in the appropriate collection path.
  /// Returns the created document id.
  Future<String> createCollection(
    Map<String, dynamic> data, {
    String? id,
    String? userId,
  }) async {
    final collectionPath = userId == null
        ? Constants.globalCollections
        : '${Constants.usersCollection}/$userId/${Constants.collectionsSub}';

    return await firebaseService.createDocument(
      collectionPath,
      data,
      docId: id,
    );
  }

  /// Update an existing collection document by id in the appropriate path.
  Future<void> updateCollection(
    String id,
    Map<String, dynamic> data, {
    String? userId,
  }) async {
    final collectionPath = userId == null
        ? Constants.globalCollections
        : '${Constants.usersCollection}/$userId/${Constants.collectionsSub}';

    await firebaseService.updateDocument(collectionPath, id, data);
  }

  /// Delete a collection document by id in the appropriate path.
  Future<void> deleteCollection(String id, {String? userId}) async {
    final collectionPath = userId == null
        ? Constants.globalCollections
        : '${Constants.usersCollection}/$userId/${Constants.collectionsSub}';

    await firebaseService.deleteDocument(collectionPath, id);
  }
}
