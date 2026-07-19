import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zikr_app/core/error/failures.dart';
import '../../domain/entities/tasbeeh_entity.dart';
import '../../domain/repositories/tasbeeh_repository.dart';
import '../datasources/tasbeeh_local_datasource.dart';
import '../datasources/tasbeeh_remote_datasource.dart';
import '../models/tasbeeh_model.dart';

class TasbeehRepositoryImpl implements TasbeehRepository {
  final TasbeehLocalDataSource localDataSource;
  final TasbeehRemoteDataSource? remoteDataSource;
  final FirebaseAuth firebaseAuth;

  TasbeehRepositoryImpl({
    required this.localDataSource,
    this.remoteDataSource,
    required this.firebaseAuth,
  });

  @override
  Future<Either<Failure, List<TasbeehEntity>>> getAllTasbeeh() async {
    try {
      final tasbeehList = await localDataSource.getAllTasbeeh();
      return Right(tasbeehList);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TasbeehEntity>> getTasbeehById(String id) async {
    try {
      final list = await localDataSource.getAllTasbeeh();
      final tasbeeh = list.firstWhere((t) => t.id == id);
      return Right(tasbeeh);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveTasbeeh(TasbeehEntity tasbeeh) async {
    try {
      await localDataSource.saveTasbeeh(TasbeehModel.fromEntity(tasbeeh));
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTasbeehCount(String id, int count) async {
    try {
      await localDataSource.setTotalCount(count);
      await _syncToFirebase(count);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getTotalCount() async {
    try {
      final count = await localDataSource.getTotalCount();
      return Right(count);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getStreakDays() async {
    try {
      final days = await localDataSource.getStreakDays();
      return Right(days);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<void> _syncToFirebase(int totalCount) async {
    if (remoteDataSource == null) return;
    
    try {
      final streakDays = await localDataSource.getStreakDays();
      await remoteDataSource!.saveStats(
        totalCount: totalCount,
        streakDays: streakDays,
      );
    } catch (e) {
      // Silent fail
    }
  }

  Future<void> saveStats({required int totalCount, required int streakDays}) async {
    if (remoteDataSource == null) return;
    try {
      await remoteDataSource!.saveStats(
        totalCount: totalCount,
        streakDays: streakDays,
      );
    } catch (e) {
      // Silent fail
    }
  }

  Future<void> syncFromFirebase() async {
    if (remoteDataSource == null) return;

    try {
      final remoteStats = await remoteDataSource!.getStats();
      final localTotal = await localDataSource.getTotalCount();
      final remoteTotal = remoteStats['totalCount'] as int;
      final remoteStreak = remoteStats['streakDays'] as int;

      if (remoteTotal > localTotal) {
        await localDataSource.setTotalCount(remoteTotal);
      }

      final localStreak = await localDataSource.getStreakDays();
      if (remoteStreak > localStreak) {
        await localDataSource.setStreakDays(remoteStreak);
      }
    } catch (e) {
      // Silent fail
    }
  }
}
