import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import '../../domain/entities/favorites_entity.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_remote_datasource.dart';
import '../models/favorites_model.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remoteDataSource;

  FavoritesRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<FavoritesEntity>>> getFavorites() async {
    try {
      final favorites = await remoteDataSource.getFavorites();
      return Right(favorites);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite(FavoritesEntity favorite) async {
    try {
      await remoteDataSource.addFavorite(FavoritesModel.fromEntity(favorite));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String id) async {
    try {
      await remoteDataSource.removeFavorite(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String id) async {
    try {
      final result = await remoteDataSource.isFavorite(id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}