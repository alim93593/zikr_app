import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zikr_app/core/error/failures.dart';

import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final FirebaseAuth firebaseAuth;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.firebaseAuth,
  });

  String? get _userId => firebaseAuth.currentUser?.uid;

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      if (_userId == null)
        return const Left(ServerFailure('Not authenticated'));
      final profile = await remoteDataSource.getProfile(_userId!);
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(ProfileEntity profile) async {
    try {
      await remoteDataSource.updateProfile(
        profile.id,
        ProfileModel(
          id: profile.id,
          displayName: profile.displayName,
          email: profile.email,
          photoUrl: profile.photoUrl,
          totalTasbeehCount: profile.totalTasbeehCount,
          currentStreak: profile.currentStreak,
          longestStreak: profile.longestStreak,
          favoritesCount: profile.favoritesCount,
          joinedAt: profile.joinedAt,
        ).toJson(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
