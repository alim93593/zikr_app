import '../../domain/entities/tasbeeh_entity.dart';

class TasbeehModel extends TasbeehEntity {
  const TasbeehModel({
    required super.id,
    required super.name,
    super.currentCount,
    super.targetCount,
    super.category,
  });

  factory TasbeehModel.fromJson(Map<String, dynamic> json) {
    return TasbeehModel(
      id: json['id'] as String,
      name: json['name'] as String,
      currentCount: json['currentCount'] as int? ?? 0,
      targetCount: json['targetCount'] as int? ?? 33,
      category: json['category'] as String? ?? 'general',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'currentCount': currentCount,
      'targetCount': targetCount,
      'category': category,
    };
  }

  factory TasbeehModel.fromEntity(TasbeehEntity entity) {
    return TasbeehModel(
      id: entity.id,
      name: entity.name,
      currentCount: entity.currentCount,
      targetCount: entity.targetCount,
      category: entity.category,
    );
  }
}