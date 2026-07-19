import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithEmail(String email, String password);
  Future<Either<Failure, UserEntity>> signUpWithEmail(String email, String password, String displayName);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, void>> updateUser(UserEntity user);
  Stream<UserEntity?> get authStateChanges;
}