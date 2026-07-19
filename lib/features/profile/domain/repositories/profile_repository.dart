import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/failures.dart';
import '../../domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, void>> updateProfile(ProfileEntity profile);
}