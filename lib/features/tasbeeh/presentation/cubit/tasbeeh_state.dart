import 'package:equatable/equatable.dart';

class TasbeehState extends Equatable {
  final int count;
  final int target;
  final int totalCount;
  final int streakDays;
  final bool isLoading;

  const TasbeehState({
    this.count = 0,
    this.target = 33,
    this.totalCount = 0,
    this.streakDays = 0,
    this.isLoading = false,
  });

  double get progress => (count / target).clamp(0.0, 1.0);
  bool get isCompleted => count >= target;

  TasbeehState copyWith({
    int? count,
    int? target,
    int? totalCount,
    int? streakDays,
    bool? isLoading,
  }) {
    return TasbeehState(
      count: count ?? this.count,
      target: target ?? this.target,
      totalCount: totalCount ?? this.totalCount,
      streakDays: streakDays ?? this.streakDays,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [count, target, totalCount, streakDays, isLoading];
}