import 'package:equatable/equatable.dart';

/// Base Failure class used across the app for functional error handling.
/// All failures should extend this so they can be compared and passed via dartz Either.
abstract class Failure extends Equatable {
  final String message;

  const Failure([this.message = 'An unexpected error occurred']);

  @override
  List<Object?> get props => [message];
}

/// Failure returned when remote calls fail (API / network / server-side)
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server Failure']);
}

/// Failure returned when cached data cannot be retrieved or saved
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache Failure']);
}

/// Failure returned on local database errors
class DatabaseFailure extends Failure {
  const DatabaseFailure([super.message = 'Database Failure']);
}
