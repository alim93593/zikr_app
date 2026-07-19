import 'package:equatable/equatable.dart';
import '../../domain/entities/favorites_entity.dart';

enum FavoritesStatus { initial, loading, loaded, error }

class FavoritesState extends Equatable {
  final FavoritesStatus status;
  final List<FavoritesEntity> favorites;
  final String? message;

  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.favorites = const [],
    this.message,
  });

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<FavoritesEntity>? favorites,
    String? message,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, favorites, message];
}