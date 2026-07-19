import 'package:equatable/equatable.dart';

class FavoritesEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final String iconName;
  final String colorHex;
  final DateTime savedAt;

  const FavoritesEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.iconName,
    required this.colorHex,
    required this.savedAt,
  });

  @override
  List<Object?> get props => [id, title, subtitle, category, iconName, colorHex, savedAt];
}