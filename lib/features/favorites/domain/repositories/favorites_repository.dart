import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import '../entities/favorites_entity.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<FavoritesEntity>>> getFavorites();
  Future<Either<Failure, void>> addFavorite(FavoritesEntity favorite);
  Future<Either<Failure, void>> removeFavorite(String id);
  Future<Either<Failure, bool>> isFavorite(String id);
}