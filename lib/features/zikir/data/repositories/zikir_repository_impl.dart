import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import '../../domain/entities/zikir.dart';
import '../../domain/entities/zikir_category.dart';
import '../../domain/repositories/zikir_repository.dart';
import '../datasources/zikir_remote_datasource.dart';
import '../models/zikir_model.dart';

class ZikirRepositoryImpl implements ZikirRepository {
  final ZikirRemoteDataSource remoteDataSource;

  ZikirRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<ZikirCategory>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Zikir>>> getZikirsByCategory(String categoryId) async {
    try {
      final zikirs = await remoteDataSource.getZikirsByCategory(categoryId);
      final favorites = await remoteDataSource.getUserFavorites();
      final updated = zikirs.map((z) {
        return ZikirModel.fromEntity(
          z.copyWith(isFavorite: favorites.contains(z.id)),
        );
      }).toList();
      return Right(updated);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Zikir>>> getZikirsByCategoryType(String type) async {
    try {
      final category = await remoteDataSource.getCategoryByType(type);
      if (category == null) return const Right([]);
      final zikirs = await remoteDataSource.getZikirsByCategory(category.id);
      final favorites = await remoteDataSource.getUserFavorites();
      final updated = zikirs.map((z) {
        return ZikirModel.fromEntity(
          z.copyWith(isFavorite: favorites.contains(z.id)),
        );
      }).toList();
      return Right(updated);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Zikir>> getZikirById(String id) async {
    try {
      final zikir = await remoteDataSource.getZikirById(id);
      if (zikir == null) return const Left(ServerFailure('Zikir not found'));
      return Right(zikir);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(Zikir zikir) async {
    try {
      final favorites = await remoteDataSource.getUserFavorites();
      if (favorites.contains(zikir.id)) {
        await remoteDataSource.removeFavorite(zikir.id);
      } else {
        await remoteDataSource.saveFavorite(ZikirModel.fromEntity(zikir));
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Zikir>>> getFavoriteZikirs() async {
    try {
      final zikirs = await remoteDataSource.getFavoriteZikirs();
      return Right(zikirs);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveTasbeehCount(String zikirId, int count) async {
    try {
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getTasbeehCount(String zikirId) async {
    try {
      return const Right(0);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}