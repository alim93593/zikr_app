import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import 'package:zikr_app/core/usecases/usecase.dart';
import '../entities/tasbeeh_entity.dart';
import '../repositories/tasbeeh_repository.dart';

class GetTasbeehList extends UseCase<List<TasbeehEntity>, NoParams> {
  final TasbeehRepository repository;
  GetTasbeehList(this.repository);

  @override
  Future<Either<Failure, List<TasbeehEntity>>> call(NoParams params) {
    return repository.getAllTasbeeh();
  }
}

class GetTasbeehTotalCount extends UseCase<int, NoParams> {
  final TasbeehRepository repository;
  GetTasbeehTotalCount(this.repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) {
    return repository.getTotalCount();
  }
}

class GetTasbeehStreak extends UseCase<int, NoParams> {
  final TasbeehRepository repository;
  GetTasbeehStreak(this.repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) {
    return repository.getStreakDays();
  }
}

class UpdateTasbeehCount extends UseCase<void, UpdateTasbeehCountParams> {
  final TasbeehRepository repository;
  UpdateTasbeehCount(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateTasbeehCountParams params) {
    return repository.updateTasbeehCount(params.id, params.count);
  }
}

class UpdateTasbeehCountParams {
  final String id;
  final int count;
  UpdateTasbeehCountParams({required this.id, required this.count});
}