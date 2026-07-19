/// Custom exceptions used in the data layer. These are converted to [Failure]s in repository implementations.
class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Server Exception']);

  @override
  String toString() => 'ServerException: $message';
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Cache Exception']);

  @override
  String toString() => 'CacheException: $message';
}

class DatabaseException implements Exception {
  final String message;
  DatabaseException([this.message = 'Database Exception']);

  @override
  String toString() => 'DatabaseException: $message';
}

/// A lightweight wrapper for Firebase-related exceptions so we don't leak Firebase types throughout domain code.
class AppFirebaseException implements Exception {
  final String message;
  AppFirebaseException([this.message = 'Firebase Exception']);

  @override
  String toString() => 'AppFirebaseException: $message';
}
