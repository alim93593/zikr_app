import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  final firestore = FirebaseFirestore.instance;

  final categories = [
    {
      'name': 'أذكار الصباح',
      'nameEn': 'Morning Azkar',
      'description': 'أذكار وتOMEMات للحماية من المكروه',
      'descriptionEn': 'Morning remembrances for protection',
      'icon': 'wb_sunny',
      'color': 0xFFFF9800,
      'order': 1,
    },
    {
      'name': 'أذكار المساء',
      'nameEn': 'Evening Azkar',
      'description': 'أذكار وتOMEMات للاستغفار والتوكل على الله',
      'descriptionEn': 'Evening remembrances for forgiveness',
      'icon': 'nightlight',
      'color': 0xFF3F51B5,
      'order': 2,
    },
    {
      'name': 'أذكار النوم',
      'nameEn': 'Sleep Azkar',
      'description': 'أذكار قبل النوم للتحصين والنوم بأمان',
      'descriptionEn': 'Remembrances before sleep',
      'icon': 'bedtime',
      'color': 0xFF673AB7,
      'order': 3,
    },
    {
      'name': 'أذكار الاستيقاظ',
      'nameEn': 'Wake Up Azkar',
      'description': 'أذكار عند الاستيقاظ من النوم',
      'descriptionEn': 'Remembrances upon waking',
      'icon': 'alarm',
      'color': 0xFF4CAF50,
      'order': 4,
    },
    {
      'name': 'دعاء الخلاء',
      'nameEn': 'Bathroom Dua',
      'description': 'دعاء دخول وخروج الخلاء',
      'descriptionEn': 'Dua when entering/exiting bathroom',
      'icon': 'door_front',
      'color': 0xFF795548,
      'order': 5,
    },
    {
      'name': 'دعاء السوق',
      'nameEn': 'Market Dua',
      'description': 'دعاء دخول السوق',
      'descriptionEn': 'Dua when entering market',
      'icon': 'store',
      'color': 0xFF607D8B,
      'order': 6,
    },
    {
      'name': 'تسابيح',
      'nameEn': 'Glorifications',
      'description': 'تسبيحات متنوعة',
      'descriptionEn': 'Various glorifications',
      'icon': 'touch_app',
      'color': 0xFF2E5A44,
      'order': 7,
    },
    {
      'name': 'أذكار المسجد',
      'nameEn': 'Mosque Azkar',
      'description': 'دعاء دخول وخروج المسجد',
      'descriptionEn': 'Dua entering/exiting mosque',
      'icon': 'mosque',
      'color': 0xFF2196F3,
      'order': 8,
    },
  ];

  final morningAzkars = [
    {
      'text':
          'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لاَ إِلَـهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
      'count': 1,
      'source': 'رواه مسلم',
    },
    {
      'text':
          'اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ النُّشُورُ',
      'count': 1,
      'source': 'رواه أبو داود والترمذي',
    },
    {
      'text':
          'اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ، وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلائِكَتَكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللهُ لاَ إِلَـهَ إِلاَّ أَنْتَ وَحْدَكَ لاَ شَرِيكَ لَكَ، وَأَنَّ مُحَمَّداً عَبْدُكَ وَرَسُولُكَ',
      'count': 4,
      'source': 'رواه أبو داود',
    },
    {
      'text':
          'اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي',
      'count': 3,
      'source': 'رواه أبو داود',
    },
    {
      'text':
          'بِسْمِ اللهِ الَّذِي لاَ يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الأَرْضِ وَلاَ فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
      'count': 3,
      'source': 'رواه أبو داود والترمذي',
    },
    {
      'text': 'سُبْحَانَ اللهِ وَبِحَمْدِهِ',
      'count': 100,
      'source': 'رواه البخاري',
    },
    {
      'text':
          'لاَ إِلَـهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
      'count': 100,
      'source': 'رواه البخاري',
    },
    {
      'text':
          'سُبْحَانَ اللهِ وَبِحَمْدِهِ، عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ، وَمِدَادَ كَلِمَاتِهِ',
      'count': 3,
      'source': 'رواه مسلم',
    },
  ];

  final eveningAzkars = [
    {
      'text':
          'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ للهِ، وَالْحَمْدُ للهِ، لاَ إِلَـهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيكَ لَهُ',
      'count': 1,
      'source': 'رواه مسلم',
    },
    {
      'text':
          'اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ الْمَصِيرُ',
      'count': 1,
      'source': 'رواه أبو داود والترمذي',
    },
    {
      'text':
          'اللَّهُمَّ إِنِّي أَمْسَيْتُ أُشْهِدُكَ، وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلائِكَتَكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللهُ لاَ إِلَـهَ إِلاَّ أَنْتَ وَحْدَكَ لاَ شَرِيكَ لَكَ',
      'count': 4,
      'source': 'رواه أبو داود',
    },
    {
      'text': 'أَعُوذُ بِكَلِمَاتِ اللهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
      'count': 3,
      'source': 'رواه أبو داود',
    },
    {
      'text': 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ',
      'count': 1,
      'source': 'رواه البخاري',
    },
  ];

  final sleepAzkars = [
    {
      'text':
          'بِاسْمِكَ رَبِّي تَوَضَّأْتُ وَبِاسْمِكَ أَرْجُو وَبِكَ أَثْبُتُ',
      'count': 1,
      'source': 'رواه أبو داود',
    },
    {
      'text': 'اللَّهُمَّ بِاسْمِكَ أَمُوتُ وَأَحْيَا',
      'count': 1,
      'source': 'رواه البخاري',
    },
    {'text': 'سُبْحَانَ اللهِ', 'count': 33, 'source': 'رواه البخاري'},
    {'text': 'الْحَمْدُ لِلَّهِ', 'count': 33, 'source': 'رواه البخاري'},
    {'text': 'اللهُ أَكْبَرُ', 'count': 34, 'source': 'رواه البخاري'},
  ];

  final wakeUpAzkars = [
    {
      'text':
          'الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
      'count': 1,
      'source': 'رواه البخاري',
    },
    {
      'text':
          'لاَ إِلَـهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، سُبْحَانَ اللهِ وَالْحَمْدُ لِلَّهِ وَلاَ إِلَـهَ إِلاَّ اللهُ وَاللهُ أَكْبَرُ وَلاَ حَوْلَ وَلاَ قُوَّةَ إِلاَّ بِاللهِ الْعَلِيِّ الْعَظِيمِ',
      'count': 1,
      'source': 'رواه مسلم',
    },
    {'text': 'اللَّهُمَّ اغْفِرْ لِي', 'count': 1, 'source': 'رواه أبو داود'},
  ];

  final toiletAzkars = [
    {
      'text': 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْخُبُثِ وَالْخَبَائِثِ',
      'count': 1,
      'source': 'رواه البخاري',
    },
    {'text': 'بِسْمِ اللهِ', 'count': 1, 'source': 'رواه مسلم'},
  ];

  final mosqueAzkars = [
    {
      'text': 'اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ',
      'count': 1,
      'source': 'رواه مسلم',
    },
    {
      'text': 'اللَّهُمَّ إِنِّي أَسْأَلُكَ فَضْلَكَ',
      'count': 1,
      'source': 'رواه مسلم',
    },
    {
      'text':
          'اللَّهُمَّ اغْفِرْ لِي ذُنُوبِي وَافْتَحْ لِي أَبْوَابَ رَحْمَتِكَ',
      'count': 1,
      'source': 'رواه مسلم',
    },
  ];

  final tasbeehList = [
    {'text': 'سُبْحَانَ اللهِ', 'count': 100},
    {'text': 'الْحَمْدُ لِلَّهِ', 'count': 100},
    {'text': 'اللهُ أَكْبَرُ', 'count': 100},
    {'text': 'لاَ إِلَـهَ إِلاَّ اللهُ', 'count': 100},
    {'text': 'سُبْحَانَ اللهِ وَبِحَمْدِهِ', 'count': 100},
    {'text': 'سُبْحَانَ اللهِ الْعَظِيمِ', 'count': 100},
  ];

  final marketAzkars = [
    {
      'text':
          'لاَ إِلَـهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، يُحْيِي وَيُمِيتُ، وَهُوَ حَيٌّ لاَ يَمُوتُ، بِيَدِهِ الْخَيْرُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
      'count': 1,
      'source': 'رواه أبو داود',
    },
  ];

  for (final category in categories) {
    final docRef = await firestore.collection('zikr_categories').add({
      ...category,
      'createdAt': FieldValue.serverTimestamp(),
    });

    final categoryId = docRef.id;
    List<Map<String, dynamic>> zikrs = [];

    switch (category['name']) {
      case 'أذكار الصباح':
        zikrs = morningAzkars;
        break;
      case 'أذكار المساء':
        zikrs = eveningAzkars;
        break;
      case 'أذكار النوم':
        zikrs = sleepAzkars;
        break;
      case 'أذكار الاستيقاظ':
        zikrs = wakeUpAzkars;
        break;
      case 'دعاء الخلاء':
        zikrs = toiletAzkars;
        break;
      case 'أذكار المسجد':
        zikrs = mosqueAzkars;
        break;
      case 'تسابيح':
        zikrs = tasbeehList;
        break;
      case 'دعاء السوق':
        zikrs = marketAzkars;
        break;
    }

    for (final zikir in zikrs) {
      await firestore
          .collection('zikr_categories')
          .doc(categoryId)
          .collection('zikrs')
          .add({
            'text': zikir['text'],
            'count': zikir['count'],
            'source': zikir['source'] ?? '',
            'createdAt': FieldValue.serverTimestamp(),
          });
    }
  }
}
