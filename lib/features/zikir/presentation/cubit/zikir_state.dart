import 'package:equatable/equatable.dart';

import '../../domain/entities/zikir.dart';
import '../../domain/entities/zikir_category.dart';

enum ZikirStatus { initial, loading, loaded, error }

class ZikirState extends Equatable {
  final ZikirStatus status;
  final List<ZikirCategory> categories;
  final List<Zikir> zikirs;
  final List<Zikir> favoriteZikirs;
  final String? selectedCategoryId;
  final String? message;

  const ZikirState({
    this.status = ZikirStatus.initial,
    this.categories = const [],
    this.zikirs = const [],
    this.favoriteZikirs = const [],
    this.selectedCategoryId,
    this.message,
  });

  ZikirState copyWith({
    ZikirStatus? status,
    List<ZikirCategory>? categories,
    List<Zikir>? zikirs,
    List<Zikir>? favoriteZikirs,
    String? selectedCategoryId,
    String? message,
  }) {
    return ZikirState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      zikirs: zikirs ?? this.zikirs,
      favoriteZikirs: favoriteZikirs ?? this.favoriteZikirs,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    status,
    categories,
    zikirs,
    favoriteZikirs,
    selectedCategoryId,
    message,
  ];
}
