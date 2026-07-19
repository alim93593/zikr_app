import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikr_app/core/utils/app_logger.dart';
import '../../domain/entities/zikir.dart';
import '../../domain/entities/zikir_category.dart';
import '../../domain/repositories/zikir_repository.dart';
import 'zikir_state.dart';

class ZikirCubit extends Cubit<ZikirState> {
  final ZikirRepository repository;

  ZikirCubit({required this.repository}) : super(const ZikirState());

  Future<void> loadCategories() async {
    logger.i('loadCategories started', tag: 'ZikirCubit');
    emit(state.copyWith(status: ZikirStatus.loading));

    final result = await repository.getCategories();

    result.fold(
      (failure) {
        logger.e('loadCategories failed', tag: 'ZikirCubit', data: failure.message);
        emit(state.copyWith(status: ZikirStatus.error, message: failure.message));
      },
      (categories) async {
        logger.i('loadCategories success', tag: 'ZikirCubit', data: {'count': categories.length});
        final updatedCategories = <ZikirCategory>[];
        for (final category in categories) {
          final zikirsResult = await repository.getZikirsByCategory(category.id);
          final count = zikirsResult.fold(
            (failure) => category.zikirCount,
            (zikirs) => zikirs.length,
          );
          updatedCategories.add(category.copyWith(zikirCount: count));
        }
        emit(state.copyWith(status: ZikirStatus.loaded, categories: updatedCategories));
      },
    );
  }

  Future<void> loadZikirsByCategory(String categoryId) async {
    logger.i('loadZikirsByCategory started', tag: 'ZikirCubit', data: {'categoryId': categoryId});
    emit(state.copyWith(status: ZikirStatus.loading, selectedCategoryId: categoryId));

    final result = await repository.getZikirsByCategory(categoryId);

    result.fold(
      (failure) {
        logger.e('loadZikirsByCategory failed', tag: 'ZikirCubit', data: failure.message);
        emit(state.copyWith(status: ZikirStatus.error, message: failure.message));
      },
      (zikirs) {
        logger.i('loadZikirsByCategory success', tag: 'ZikirCubit', data: {'count': zikirs.length});
        emit(state.copyWith(status: ZikirStatus.loaded, zikirs: zikirs));
      },
    );
  }

  Future<void> loadZikirsByCategoryType(String type) async {
    logger.i('loadZikirsByCategoryType started', tag: 'ZikirCubit', data: {'type': type});

    final names = type == 'morning'
        ? ['morning', 'الصباح', 'أذكار الصباح', 'Morning Azkar', 'Morning']
        : ['evening', 'المساء', 'أذكار المساء', 'Evening Azkar', 'Evening'];

    final typeLower = type.toLowerCase();
    final category = state.categories.where((c) {
      return c.type.toLowerCase() == typeLower ||
          names.any((n) =>
              c.name.toLowerCase() == n.toLowerCase() ||
              c.nameAr.toLowerCase() == n.toLowerCase());
    }).firstOrNull;

    if (category != null) {
      await loadZikirsByCategory(category.id);
    } else {
      emit(state.copyWith(
        status: ZikirStatus.error,
        message: 'لم يتم العثور على تصنيف $type',
        selectedCategoryId: type,
      ));
    }
  }

  Future<void> toggleFavorite(Zikir zikir) async {
    logger.i('toggleFavorite', tag: 'ZikirCubit', data: {'zikirId': zikir.id});
    final isCurrentlyFavorite = state.favoriteZikirs.any((z) => z.id == zikir.id);
    final newFavorite = !zikir.isFavorite;
    final updatedZikirs = state.zikirs.map((z) {
      if (z.id == zikir.id) {
        return z.copyWith(isFavorite: newFavorite);
      }
      return z;
    }).toList();
    if (isCurrentlyFavorite) {
      final updatedFavorites = state.favoriteZikirs.where((z) => z.id != zikir.id).toList();
      emit(state.copyWith(zikirs: updatedZikirs, favoriteZikirs: updatedFavorites));
    } else {
      final updatedFavorites = [...state.favoriteZikirs, zikir.copyWith(isFavorite: true)];
      emit(state.copyWith(zikirs: updatedZikirs, favoriteZikirs: updatedFavorites));
    }
    try {
      await repository.toggleFavorite(zikir);
      if (!isCurrentlyFavorite) {
        await loadFavoriteZikirs();
      }
    } catch (e) {
      logger.e('toggleFavorite failed', tag: 'ZikirCubit', data: e.toString());
      emit(state.copyWith(zikirs: state.zikirs, favoriteZikirs: state.favoriteZikirs));
      await loadFavoriteZikirs();
    }
  }

  Future<void> loadFavoriteZikirs() async {
    logger.i('loadFavoriteZikirs started', tag: 'ZikirCubit');
    final result = await repository.getFavoriteZikirs();

    result.fold(
      (failure) {
        logger.e('loadFavoriteZikirs failed', tag: 'ZikirCubit', data: failure.message);
      },
      (zikirs) {
        logger.i('loadFavoriteZikirs success', tag: 'ZikirCubit', data: {'count': zikirs.length});
        emit(state.copyWith(favoriteZikirs: zikirs));
      },
    );
  }

  void clearZikirs() {
    logger.i('clearZikirs', tag: 'ZikirCubit');
    emit(state.copyWith(zikirs: [], selectedCategoryId: null));
  }
}
