import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import 'package:zikr_app/core/usecases/usecase.dart';

import '../entities/collection_item.dart';
import '../repositories/home_repository.dart';

class GetCollections implements UseCase<List<CollectionItem>, NoParams> {
  final HomeRepository repository;
  GetCollections(this.repository);

  @override
  Future<Either<Failure, List<CollectionItem>>> call(NoParams params) async {
    return await repository.getCollections();
  }
}
