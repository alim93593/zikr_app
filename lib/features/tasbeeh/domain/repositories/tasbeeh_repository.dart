import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import '../entities/tasbeeh_entity.dart';

abstract class TasbeehRepository {
  Future<Either<Failure, List<TasbeehEntity>>> getAllTasbeeh();
  Future<Either<Failure, TasbeehEntity>> getTasbeehById(String id);
  Future<Either<Failure, void>> saveTasbeeh(TasbeehEntity tasbeeh);
  Future<Either<Failure, void>> updateTasbeehCount(String id, int count);
  Future<Either<Failure, int>> getTotalCount();
  Future<Either<Failure, int>> getStreakDays();
}