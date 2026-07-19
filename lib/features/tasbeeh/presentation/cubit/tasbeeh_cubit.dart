import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikr_app/core/usecases/usecase.dart';
import 'package:zikr_app/core/utils/app_logger.dart';
import '../../data/datasources/tasbeeh_local_datasource.dart';
import '../../data/repositories/tasbeeh_repository_impl.dart';
import '../../domain/usecases/tasbeeh_usecases.dart';
import 'tasbeeh_state.dart';

class TasbeehCubit extends Cubit<TasbeehState> {
  final GetTasbeehTotalCount getTotalCount;
  final GetTasbeehStreak getStreak;
  final UpdateTasbeehCount updateCount;
  final TasbeehLocalDataSource localDataSource;
  final TasbeehRepositoryImpl? _repositoryImpl;

  TasbeehCubit({
    required this.getTotalCount,
    required this.getStreak,
    required this.updateCount,
    required this.localDataSource,
    TasbeehRepositoryImpl? repositoryImpl,
  }) : _repositoryImpl = repositoryImpl, super(const TasbeehState());

  Future<void> loadStats() async {
    logger.i('loadStats started', tag: 'TasbeehCubit');
    emit(state.copyWith(isLoading: true));

    try {
      await _repositoryImpl?.syncFromFirebase();
    } catch (e) {
      logger.e('syncFromFirebase failed', tag: 'TasbeehCubit', data: e.toString());
    }

    if (isClosed) return;

    final totalResult = await getTotalCount(NoParams());
    final streakResult = await getStreak(NoParams());

    if (isClosed) return;

    int total = 0;
    int streak = 0;

    totalResult.fold((l) => null, (r) => total = r);
    streakResult.fold((l) => null, (r) => streak = r);

    streak = await _recalculateStreak(streak);

    logger.i('loadStats success', tag: 'TasbeehCubit', data: {'total': total, 'streak': streak});
    emit(state.copyWith(
      totalCount: total,
      streakDays: streak,
      isLoading: false,
    ));
  }

  Future<void> increment() async {
    final newCount = state.count + 1;
    final newTotal = state.totalCount + 1;
    if (isClosed) return;
    emit(state.copyWith(count: newCount, totalCount: newTotal));
    await updateCount(UpdateTasbeehCountParams(id: 'current', count: newTotal));
    await _recordTodayActivity();
  }

  void setTarget(int target) {
    if (isClosed) return;
    emit(state.copyWith(target: target, count: 0));
  }

  void reset() {
    if (isClosed) return;
    emit(state.copyWith(count: 0));
  }

  Future<int> _recalculateStreak(int currentStreak) async {
    final lastActiveDate = await localDataSource.getLastActiveDate();
    final today = _todayString();

    if (lastActiveDate == null) {
      return currentStreak;
    }

    if (lastActiveDate == today) {
      return currentStreak;
    }

    final yesterday = _yesterdayString();
    if (lastActiveDate == yesterday) {
      return currentStreak;
    }

    await localDataSource.setStreakDays(0);
    return 0;
  }

  Future<void> _recordTodayActivity() async {
    final today = _todayString();
    final lastActiveDate = await localDataSource.getLastActiveDate();

    if (lastActiveDate == today) return;

    final yesterday = _yesterdayString();
    int newStreak;

    if (lastActiveDate == yesterday) {
      newStreak = state.streakDays + 1;
    } else {
      newStreak = 1;
    }

    await localDataSource.setLastActiveDate(today);
    await localDataSource.setStreakDays(newStreak);

    try {
      await _repositoryImpl?.saveStats(
        totalCount: state.totalCount,
        streakDays: newStreak,
      );
    } catch (_) {}

    if (isClosed) return;
    emit(state.copyWith(streakDays: newStreak));
  }

  String _todayString() {
    final now = DateTime.now();
    return '${now.year}-${_pad(now.month)}-${_pad(now.day)}';
  }

  String _yesterdayString() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return '${yesterday.year}-${_pad(yesterday.month)}-${_pad(yesterday.day)}';
  }

  String _pad(int n) => n.toString().padLeft(2, '0');
}