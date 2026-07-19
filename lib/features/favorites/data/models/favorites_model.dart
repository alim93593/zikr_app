import '../../domain/entities/favorites_entity.dart';

class FavoritesModel extends FavoritesEntity {
  const FavoritesModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.category,
    required super.iconName,
    required super.colorHex,
    required super.savedAt,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) {
    return FavoritesModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      category: json['category'] as String,
      iconName: json['iconName'] as String? ?? 'star',
      colorHex: json['colorHex'] as String? ?? '#0A73FF',
      savedAt: DateTime.tryParse(json['savedAt'] as String? ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'category': category,
      'iconName': iconName,
      'colorHex': colorHex,
      'savedAt': savedAt.toIso8601String(),
    };
  }

  factory FavoritesModel.fromEntity(FavoritesEntity entity) {
    return FavoritesModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      category: entity.category,
      iconName: entity.iconName,
      colorHex: entity.colorHex,
      savedAt: entity.savedAt,
    );
  }
}