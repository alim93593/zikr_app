import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:zikr_app/core/error/exceptions.dart';
import 'package:zikr_app/core/error/failures.dart';
import 'package:zikr_app/core/firebase/firebase_service.dart';
import 'package:zikr_app/core/local/local_storage.dart';
import 'package:zikr_app/core/network/network_info.dart';

import '../../domain/entities/collection_item.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';
import '../models/collection_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final LocalStorage localStorage;
  final FirebaseService firebaseService;

  static const _cacheKey = 'collections_cache';

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localStorage,
    required this.firebaseService,
  });

  @override
  Future<Either<Failure, List<CollectionItem>>> getCollections() async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final userId = firebaseService.auth.currentUser?.uid;
        final models = await remoteDataSource.fetchCollections(userId: userId);
        // Cache locally
        try {
          final jsonList = models.map((m) => (m.toJson())).toList();
          await localStorage.setString(_cacheKey, jsonEncode(jsonList));
        } catch (_) {}
        return Right(models);
      } else {
        // Try load from cache
        final cached = localStorage.getString(_cacheKey);
        if (cached == null) return Left(CacheFailure('No cached data'));
        final list = jsonDecode(cached) as List<dynamic>;
        final models = list
            .map((e) => CollectionModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        return Right(models);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, String>> createCollection(
    Map<String, dynamic> data, {
    String? id,
  }) async {
    try {
      final userId = firebaseService.auth.currentUser?.uid;
      final newId = await remoteDataSource.createCollection(
        data,
        id: id,
        userId: userId,
      );
      return Right(newId);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateCollection(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final userId = firebaseService.auth.currentUser?.uid;
      await remoteDataSource.updateCollection(id, data, userId: userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCollection(String id) async {
    try {
      final userId = firebaseService.auth.currentUser?.uid;
      await remoteDataSource.deleteCollection(id, userId: userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
