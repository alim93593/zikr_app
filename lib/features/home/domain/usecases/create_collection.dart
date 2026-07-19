import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import 'package:zikr_app/core/usecases/usecase.dart';

import '../repositories/home_repository.dart';

class CreateCollection implements UseCase<String, Map<String, dynamic>> {
  final HomeRepository repository;
  CreateCollection(this.repository);

  @override
  Future<Either<Failure, String>> call(Map<String, dynamic> params) async {
    final id = params['id'] as String?;
    return await repository.createCollection(params, id: id);
  }
}
