import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import 'package:zikr_app/core/usecases/usecase.dart';

import '../repositories/home_repository.dart';

class DeleteCollection implements UseCase<void, String> {
  final HomeRepository repository;
  DeleteCollection(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteCollection(id);
  }
}
