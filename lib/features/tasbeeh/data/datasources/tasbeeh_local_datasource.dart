import 'package:shared_preferences/shared_preferences.dart';
import 'package:zikr_app/features/tasbeeh/data/models/tasbeeh_model.dart';

abstract class TasbeehLocalDataSource {
  Future<List<TasbeehModel>> getAllTasbeeh();
  Future<void> saveTasbeeh(TasbeehModel tasbeeh);
  Future<int> getTotalCount();
  Future<int> getStreakDays();
  Future<void> setTotalCount(int count);
  Future<void> setStreakDays(int days);
  Future<String?> getLastActiveDate();
  Future<void> setLastActiveDate(String date);
}

class TasbeehLocalDataSourceImpl implements TasbeehLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _totalCountKey = 'total_tasbeeh_count';
  static const String _streakKey = 'tasbeeh_streak_days';
  static const String _lastActiveDateKey = 'tasbeeh_last_active_date';

  TasbeehLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TasbeehModel>> getAllTasbeeh() async {
    return [
      const TasbeehModel(id: '1', name: 'سبحان الله', targetCount: 33, category: 'morning'),
      const TasbeehModel(id: '2', name: 'الحمد لله', targetCount: 33, category: 'general'),
      const TasbeehModel(id: '3', name: 'الله أكبر', targetCount: 34, category: 'general'),
      const TasbeehModel(id: '4', name: 'لا إله إلا الله', targetCount: 100, category: 'evening'),
      const TasbeehModel(id: '5', name: 'أستغفر الله', targetCount: 100, category: 'forgiveness'),
    ];
  }

  @override
  Future<void> saveTasbeeh(TasbeehModel tasbeeh) async {}

  @override
  Future<int> getTotalCount() async {
    return sharedPreferences.getInt(_totalCountKey) ?? 0;
  }

  @override
  Future<int> getStreakDays() async {
    return sharedPreferences.getInt(_streakKey) ?? 0;
  }

  @override
  Future<void> setTotalCount(int count) async {
    await sharedPreferences.setInt(_totalCountKey, count);
  }

  @override
  Future<void> setStreakDays(int days) async {
    await sharedPreferences.setInt(_streakKey, days);
  }

  @override
  Future<String?> getLastActiveDate() async {
    return sharedPreferences.getString(_lastActiveDateKey);
  }

  @override
  Future<void> setLastActiveDate(String date) async {
    await sharedPreferences.setString(_lastActiveDateKey, date);
  }
}
