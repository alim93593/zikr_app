import 'package:equatable/equatable.dart';

class Zikir extends Equatable {
  final String id;
  final String text;
  final String? transliteration;
  final String? translation;
  final int count;
  final String categoryId;
  final String categoryName;
  final int repetitionCount;
  final bool isFavorite;

  const Zikir({
    required this.id,
    required this.text,
    this.transliteration,
    this.translation,
    required this.count,
    required this.categoryId,
    required this.categoryName,
    this.repetitionCount = 1,
    this.isFavorite = false,
  });

  Zikir copyWith({
    String? id,
    String? text,
    String? transliteration,
    String? translation,
    int? count,
    String? categoryId,
    String? categoryName,
    int? repetitionCount,
    bool? isFavorite,
  }) {
    return Zikir(
      id: id ?? this.id,
      text: text ?? this.text,
      transliteration: transliteration ?? this.transliteration,
      translation: translation ?? this.translation,
      count: count ?? this.count,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      repetitionCount: repetitionCount ?? this.repetitionCount,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        id,
        text,
        transliteration,
        translation,
        count,
        categoryId,
        categoryName,
        repetitionCount,
        isFavorite,
      ];
}