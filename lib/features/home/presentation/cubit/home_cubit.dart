import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikr_app/core/error/failures.dart';
import 'package:zikr_app/core/usecases/usecase.dart';
import 'package:zikr_app/core/utils/logger.dart';

import '../../domain/entities/collection_item.dart';
import '../../domain/usecases/get_collections.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCollections getCollections;
  HomeCubit({required this.getCollections}) : super(const HomeState());

  Future<void> load() async {
    emit(state.copyWith(status: HomeStatus.loading));

    final Either<Failure, List<CollectionItem>> result = await getCollections(
      NoParams(),
    );

    result.fold(
      (failure) {
        AppLogger.e('Failed to load collections: ${failure.message}');
        emit(
          state.copyWith(status: HomeStatus.error, message: failure.message),
        );
      },
      (data) {
        emit(state.copyWith(status: HomeStatus.loaded, collections: data));
      },
    );
  }
}
