import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import 'package:zikr_app/core/usecases/usecase.dart';
import '../entities/zikir.dart';
import '../entities/zikir_category.dart';
import '../repositories/zikir_repository.dart';

class GetZikirCategories extends UseCase<List<ZikirCategory>, NoParams> {
  final ZikirRepository repository;
  GetZikirCategories(this.repository);

  @override
  Future<Either<Failure, List<ZikirCategory>>> call(NoParams params) {
    return repository.getCategories();
  }
}

class GetZikirsByCategory extends UseCase<List<Zikir>, String> {
  final ZikirRepository repository;
  GetZikirsByCategory(this.repository);

  @override
  Future<Either<Failure, List<Zikir>>> call(String categoryId) {
    return repository.getZikirsByCategory(categoryId);
  }
}

class ToggleZikirFavorite extends UseCase<void, Zikir> {
  final ZikirRepository repository;
  ToggleZikirFavorite(this.repository);

  @override
  Future<Either<Failure, void>> call(Zikir zikir) {
    return repository.toggleFavorite(zikir);
  }
}

class GetFavoriteZikirs extends UseCase<List<Zikir>, NoParams> {
  final ZikirRepository repository;
  GetFavoriteZikirs(this.repository);

  @override
  Future<Either<Failure, List<Zikir>>> call(NoParams params) {
    return repository.getFavoriteZikirs();
  }
}