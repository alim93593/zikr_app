import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appName': 'Zikr',
      'home': 'Home',
      'tasbeeh': 'Tasbeeh',
      'favorites': 'Favorites',
      'settings': 'Settings',
      'dailyReminder': 'Daily Reminder',
      'sacredMoments': 'Sacred Moments',
      'exploreCollection': 'Explore Collection',
      'essenceOfReminder': 'Essence of Reminder',
      'browseAll': 'Browse All',
      'listenRecitations': 'Listen to Recitations',
      'search': 'Search',
      'theSanctuary': 'The Sanctuary',
      'count': 'Count',
      'reset': 'Reset',
      'target': 'Target',
      'noFavorites': 'No favorites yet',
      'addToFavorites': 'Add to favorites',
      'removeFromFavorites': 'Remove from favorites',
      'general': 'General',
      'appearance': 'Appearance',
      'notifications': 'Notifications',
      'language': 'Language',
      'darkMode': 'Dark Mode',
      'arabic': 'Arabic',
      'english': 'English',
      'about': 'About',
      'version': 'Version',
      'morningAzkar': 'Morning Azkar',
      'eveningAzkar': 'Evening Azkar',
      'sleepAzkar': 'Sleep Azkar',
      'quranQuotes': 'Quran Quotes',
      'prophetPrayers': 'Prophet Prayers',
      'forgiveness': 'Forgiveness',
      'gratitude': 'Gratitude',
      'protection': 'Protection',
      'healing': 'Healing',
      'knowledge': 'Knowledge',
      'patience': 'Patience',
      'todayProgress': "Today's Progress",
      'totalCount': 'Total Count',
      'currentStreak': 'Current Streak',
      'days': 'days',
    },
    'ar': {
      'appName': 'الذكر',
      'home': 'الرئيسية',
      'tasbeeh': 'التسبيح',
      'favorites': 'المفضلة',
      'settings': 'الإعدادات',
      'dailyReminder': 'تذكير يومي',
      'sacredMoments': 'لحظات مقدسة',
      'exploreCollection': 'استكشف المجموعة',
      'essenceOfReminder': 'جوهر الذكر',
      'browseAll': 'تصفح الكل',
      'listenRecitations': 'استمع للقرآن',
      'search': 'بحث',
      'theSanctuary': 'الملاذ',
      'count': 'العدد',
      'reset': 'إعادة',
      'target': 'الهدف',
      'noFavorites': 'لا توجد مفضلات بعد',
      'addToFavorites': 'إضافة للمفضلة',
      'removeFromFavorites': 'إزالة من المفضلة',
      'general': 'عام',
      'appearance': 'المظهر',
      'notifications': 'الإشعارات',
      'language': 'اللغة',
      'darkMode': 'الوضع الليلي',
      'arabic': 'العربية',
      'english': 'الإنجليزية',
      'about': 'عن التطبيق',
      'version': 'الإصدار',
      'morningAzkar': 'أذكار الصباح',
      'eveningAzkar': 'أذكار المساء',
      'sleepAzkar': 'أذكار النوم',
      'quranQuotes': 'آيات قرآنية',
      'prophetPrayers': 'أدعية نبوية',
      'forgiveness': 'الاستغفار',
      'gratitude': 'الشكر',
      'protection': 'الحفظ',
      'healing': 'الشفاء',
      'knowledge': 'العلم',
      'patience': 'الصبر',
      'todayProgress': 'تقدم اليوم',
      'totalCount': 'العدد الإجمالي',
      'currentStreak': 'السلسلة الحالية',
      'days': 'أيام',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
