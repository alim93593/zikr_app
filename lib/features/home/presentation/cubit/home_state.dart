import 'package:equatable/equatable.dart';

import '../../domain/entities/collection_item.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<CollectionItem> collections;
  final String? message;

  const HomeState({this.status = HomeStatus.initial, this.collections = const [], this.message});

  HomeState copyWith({HomeStatus? status, List<CollectionItem>? collections, String? message}) {
    return HomeState(status: status ?? this.status, collections: collections ?? this.collections, message: message ?? this.message);
  }

  @override
  List<Object?> get props => [status, collections, message];
}
