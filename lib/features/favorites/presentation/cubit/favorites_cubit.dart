import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikr_app/core/usecases/usecase.dart';
import '../../domain/usecases/favorites_usecases.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavoritesList getFavoritesList;
  final RemoveFavoriteItem removeFavorite;

  FavoritesCubit({
    required this.getFavoritesList,
    required this.removeFavorite,
  }) : super(const FavoritesState());

  Future<void> loadFavorites() async {
    emit(state.copyWith(status: FavoritesStatus.loading));

    final result = await getFavoritesList(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        status: FavoritesStatus.error,
        message: failure.message,
      )),
      (favorites) => emit(state.copyWith(
        status: FavoritesStatus.loaded,
        favorites: favorites,
      )),
    );
  }

  Future<void> remove(String id) async {
    await removeFavorite(id);
    final updated = state.favorites.where((f) => f.id != id).toList();
    emit(state.copyWith(favorites: updated));
  }
}