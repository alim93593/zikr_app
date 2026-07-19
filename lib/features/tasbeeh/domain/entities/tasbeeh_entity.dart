import 'package:equatable/equatable.dart';

class TasbeehEntity extends Equatable {
  final String id;
  final String name;
  final int currentCount;
  final int targetCount;
  final String category;

  const TasbeehEntity({
    required this.id,
    required this.name,
    this.currentCount = 0,
    this.targetCount = 33,
    this.category = 'general',
  });

  double get progress => (currentCount / targetCount).clamp(0.0, 1.0);
  bool get isCompleted => currentCount >= targetCount;

  TasbeehEntity copyWith({
    String? id,
    String? name,
    int? currentCount,
    int? targetCount,
    String? category,
  }) {
    return TasbeehEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      currentCount: currentCount ?? this.currentCount,
      targetCount: targetCount ?? this.targetCount,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [id, name, currentCount, targetCount, category];
}