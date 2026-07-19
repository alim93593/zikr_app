import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';

import '../entities/collection_item.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<CollectionItem>>> getCollections();

  Future<Either<Failure, String>> createCollection(
    Map<String, dynamic> data, {
    String? id,
  });

  Future<Either<Failure, void>> updateCollection(
    String id,
    Map<String, dynamic> data,
  );

  Future<Either<Failure, void>> deleteCollection(String id);
}
