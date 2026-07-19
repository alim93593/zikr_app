import '../../domain/entities/zikir.dart';

class ZikirModel extends Zikir {
  const ZikirModel({
    required super.id,
    required super.text,
    super.transliteration,
    super.translation,
    required super.count,
    required super.categoryId,
    required super.categoryName,
    super.repetitionCount,
    super.isFavorite,
  });

  factory ZikirModel.fromJson(Map<String, dynamic> json) {
    return ZikirModel(
      id: json['id'] as String? ?? '',
      text: (json['text'] as String?) ?? (json['title'] as String?) ?? '',
      transliteration: json['transliteration'] as String?,
      translation: json['translation'] as String?,
      count: json['count'] as int? ?? json['repeatCount'] as int? ?? 1,
      categoryId: json['categoryId'] as String? ?? json['category'] as String? ?? '',
      categoryName: json['categoryName'] as String? ?? json['category'] as String? ?? '',
      repetitionCount: json['repetitionCount'] as int? ?? 1,
      isFavorite: json['isFavorite'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'transliteration': transliteration,
      'translation': translation,
      'count': count,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'repetitionCount': repetitionCount,
      'isFavorite': isFavorite,
    };
  }

  factory ZikirModel.fromEntity(Zikir zikir) {
    return ZikirModel(
      id: zikir.id,
      text: zikir.text,
      transliteration: zikir.transliteration,
      translation: zikir.translation,
      count: zikir.count,
      categoryId: zikir.categoryId,
      categoryName: zikir.categoryName,
      repetitionCount: zikir.repetitionCount,
      isFavorite: zikir.isFavorite,
    );
  }
}