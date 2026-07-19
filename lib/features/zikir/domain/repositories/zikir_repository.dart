import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import '../entities/zikir.dart';
import '../entities/zikir_category.dart';

abstract class ZikirRepository {
  Future<Either<Failure, List<ZikirCategory>>> getCategories();
  Future<Either<Failure, List<Zikir>>> getZikirsByCategory(String categoryId);
  Future<Either<Failure, List<Zikir>>> getZikirsByCategoryType(String type);
  Future<Either<Failure, Zikir>> getZikirById(String id);
  Future<Either<Failure, void>> toggleFavorite(Zikir zikir);
  Future<Either<Failure, List<Zikir>>> getFavoriteZikirs();
  Future<Either<Failure, void>> saveTasbeehCount(String zikirId, int count);
  Future<Either<Failure, int>> getTasbeehCount(String zikirId);
}