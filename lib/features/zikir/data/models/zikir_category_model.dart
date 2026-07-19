import '../../domain/entities/zikir_category.dart';

class ZikirCategoryModel extends ZikirCategory {
  const ZikirCategoryModel({
    required super.id,
    required super.name,
    required super.nameAr,
    required super.icon,
    required super.colorHex,
    required super.zikirCount,
    super.description,
    super.type,
  });

  factory ZikirCategoryModel.fromJson(Map<String, dynamic> json) {
    return ZikirCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      nameAr: json['name'] as String? ?? json['nameAr'] as String? ?? '',
      icon: json['icon'] as String? ?? 'star',
      colorHex: json['color'] != null
          ? '#${(json['color'] as int).toRadixString(16).substring(2)}'
          : json['colorHex'] as String? ?? '#0A73FF',
      zikirCount: json['zikirCount'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameAr': nameAr,
      'icon': icon,
      'colorHex': colorHex,
      'zikirCount': zikirCount,
      'description': description,
      'type': type,
    };
  }
}