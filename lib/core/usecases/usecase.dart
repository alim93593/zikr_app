import 'package:dartz/dartz.dart';

import '../error/failures.dart';

/// Generic UseCase contract for all interactors in the Domain layer.
/// Returns `Either<Failure, T>` to enforce functional error handling.
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Simple empty params class for usecases that don't require inputs.
class NoParams {}
