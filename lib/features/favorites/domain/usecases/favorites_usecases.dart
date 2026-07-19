import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import 'package:zikr_app/core/usecases/usecase.dart';
import '../entities/favorites_entity.dart';
import '../repositories/favorites_repository.dart';

class GetFavoritesList extends UseCase<List<FavoritesEntity>, NoParams> {
  final FavoritesRepository repository;
  GetFavoritesList(this.repository);

  @override
  Future<Either<Failure, List<FavoritesEntity>>> call(NoParams params) {
    return repository.getFavorites();
  }
}

class AddFavoriteItem extends UseCase<void, FavoritesEntity> {
  final FavoritesRepository repository;
  AddFavoriteItem(this.repository);

  @override
  Future<Either<Failure, void>> call(FavoritesEntity params) {
    return repository.addFavorite(params);
  }
}

class RemoveFavoriteItem extends UseCase<void, String> {
  final FavoritesRepository repository;
  RemoveFavoriteItem(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) {
    return repository.removeFavorite(params);
  }
}