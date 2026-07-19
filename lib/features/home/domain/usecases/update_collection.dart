import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import 'package:zikr_app/core/usecases/usecase.dart';

import '../repositories/home_repository.dart';

class UpdateCollection implements UseCase<void, Map<String, dynamic>> {
  final HomeRepository repository;
  UpdateCollection(this.repository);

  @override
  Future<Either<Failure, void>> call(Map<String, dynamic> params) async {
    final id = params['id'] as String;
    final data = params['data'] as Map<String, dynamic>;
    return await repository.updateCollection(id, data);
  }
}
