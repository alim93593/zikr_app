import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import 'package:zikr_app/core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmail extends UseCase<UserEntity, SignInParams> {
  final AuthRepository repository;
  SignInWithEmail(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) {
    return repository.signInWithEmail(params.email, params.password);
  }
}

class SignInParams {
  final String email;
  final String password;
  SignInParams({required this.email, required this.password});
}

class SignUpWithEmail extends UseCase<UserEntity, SignUpParams> {
  final AuthRepository repository;
  SignUpWithEmail(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) {
    return repository.signUpWithEmail(params.email, params.password, params.displayName);
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String displayName;
  SignUpParams({required this.email, required this.password, required this.displayName});
}

class SignOut extends UseCase<void, NoParams> {
  final AuthRepository repository;
  SignOut(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.signOut();
  }
}

class GetCurrentUser extends UseCase<UserEntity, NoParams> {
  final AuthRepository repository;
  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return repository.getCurrentUser();
  }
}