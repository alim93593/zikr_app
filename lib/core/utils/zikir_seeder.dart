import 'package:cloud_firestore/cloud_firestore.dart';

class ZikirSeeder {
  static Future<void> seedCategories() async {
    final firestore = FirebaseFirestore.instance;
    final categories = [
      {
        'id': 'morning',
        'name': 'Morning Azkar',
        'nameAr': 'أذكار الصباح',
        'icon': 'wb_sunny',
        'colorHex': '#FF9800',
        'description': 'Remembrance for morning',
        'zikirCount': 12,
      },
      {
        'id': 'evening',
        'name': 'Evening Azkar',
        'nameAr': 'أذكار المساء',
        'icon': 'nightlight',
        'colorHex': '#3F51B5',
        'description': 'Remembrance for evening',
        'zikirCount': 10,
      },
      {
        'id': 'sleep',
        'name': 'Sleep Azkar',
        'nameAr': 'أذكار النوم',
        'icon': 'bedtime',
        'colorHex': '#9C27B0',
        'description': 'Remembrance before sleep',
        'zikirCount': 8,
      },
      {
        'id': 'prayers',
        'name': 'Prophet Prayers',
        'nameAr': 'أدعية نبوية',
        'icon': 'menu_book',
        'colorHex': '#009688',
        'description': 'Prophet Muhammad prayers',
        'zikirCount': 15,
      },
      {
        'id': 'quran',
        'name': 'Quran Verses',
        'nameAr': 'آيات قرآنية',
        'icon': 'menu_open',
        'colorHex': '#4CAF50',
        'description': 'Holy Quran verses',
        'zikirCount': 20,
      },
      {
        'id': 'forgiveness',
        'name': 'Forgiveness',
        'nameAr': 'الاستغفار',
        'icon': 'refresh',
        'colorHex': '#2196F3',
        'description': 'Seeking forgiveness',
        'zikirCount': 6,
      },
      {
        'id': 'gratitude',
        'name': 'Gratitude',
        'nameAr': 'الحمد والشكر',
        'icon': 'favorite',
        'colorHex': '#FFC107',
        'description': 'Thanks and gratitude',
        'zikirCount': 7,
      },
      {
        'id': 'protection',
        'name': 'Protection',
        'nameAr': 'الحفظ والحماية',
        'icon': 'shield',
        'colorHex': '#F44336',
        'description': 'Seeking protection',
        'zikirCount': 9,
      },
    ];

    for (final category in categories) {
      await firestore.collection('zikr_categories').doc(category['id'] as String).set(category);
    }
  }

  static Future<void> seedZikrs() async {
    final firestore = FirebaseFirestore.instance;
    final zikrs = {
      'morning': [
        {'text': 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ رَبِّ الْعَالَمِينَ', 'transliteration': 'Asbahna wa asbahal mulku lillah rabbil alameen', 'translation': 'We have reached the morning and the sovereignty belongs to Allah', 'count': 1},
        {'text': 'اللَّهُمَّ بِكَ أَصْبَحْنَا وَبِكَ أَمْسَيْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ', 'transliteration': 'Allahumma bika asbahna wa bika amsayna wa bika nahya wa bika namoot', 'translation': 'O Allah, by You we have reached the morning', 'count': 1},
        {'text': 'سُبْحَانَ اللهِ وَبِحَمْدِهِ', 'transliteration': 'Subhan Allah wa bi hamdih', 'translation': 'Glory be to Allah and praise be to Him', 'count': 100},
        {'text': 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ', 'transliteration': 'La ilaha illallah wahdahu la shareeka lah', 'translation': 'There is no god but Allah alone', 'count': 100},
      ],
      'evening': [
        {'text': 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ', 'transliteration': 'Amsayna wa amsal mulku lillah', 'translation': 'We have reached the evening and the sovereignty belongs to Allah', 'count': 1},
        {'text': 'اللَّهُمَّ بِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا', 'transliteration': 'Allahumma bika amsayna wa bika asbahna', 'translation': 'O Allah, by You we have reached the evening', 'count': 1},
        {'text': 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ', 'transliteration': 'Aoodhu bikalimatillahit tammat min sharri ma khalaq', 'translation': 'I seek refuge in the perfect words of Allah', 'count': 3},
      ],
      'forgiveness': [
        {'text': 'أَسْتَغْفِرُ اللَّهَ', 'transliteration': 'Astaghfirullah', 'translation': 'I seek forgiveness from Allah', 'count': 100},
        {'text': 'اللَّهُمَّ اغْفِرْ لِي وَتُبْ عَلَيَّ', 'transliteration': 'Allahumma ighfir li wa tub alayya', 'translation': 'O Allah, forgive me and accept my repentance', 'count': 100},
      ],
    };

    for (final entry in zikrs.entries) {
      for (int i = 0; i < entry.value.length; i++) {
        final zikir = Map<String, dynamic>.from(entry.value[i]);
        zikir['id'] = '${entry.key}_$i';
        zikir['categoryId'] = entry.key;
        zikir['categoryName'] = _getCategoryName(entry.key);
        await firestore.collection('zikr_categories').doc(entry.key).collection('zikrs').add(zikir);
      }
    }
  }

  static String _getCategoryName(String id) {
    switch (id) {
      case 'morning':
        return 'أذكار الصباح';
      case 'evening':
        return 'أذكار المساء';
      case 'forgiveness':
        return 'الاستغفار';
      default:
        return '';
    }
  }
}