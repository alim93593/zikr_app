import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:zikr_app/core/utils/app_logger.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    _initialized = true;
    logger.i('NotificationService initialized', tag: 'NotificationService');
  }

  void _onNotificationTap(NotificationResponse response) {
    logger.i(
      'Notification tapped: ${response.payload}',
      tag: 'NotificationService',
    );
  }

  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final androidPlugin = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      return await androidPlugin?.requestNotificationsPermission() ?? false;
    } else if (Platform.isIOS) {
      final iosPlugin = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      return await iosPlugin?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }
    return true;
  }

  Future<void> scheduleMorningReminder({
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    await cancelMorningReminder();
    final scheduledDate = _nextInstanceOfTime(hour, minute);
    const androidDetails = AndroidNotificationDetails(
      'morning_azkar_channel',
      'أذكار الصباح',
      channelDescription: 'تذكير بأذكار الصباح',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.zonedSchedule(
      0,
      title,
      body,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    logger.i(
      'Scheduled morning reminder at $hour:$minute',
      tag: 'NotificationService',
    );
  }

  Future<void> scheduleEveningReminder({
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    await cancelEveningReminder();
    final scheduledDate = _nextInstanceOfTime(hour, minute);
    const androidDetails = AndroidNotificationDetails(
      'evening_azkar_channel',
      'أذكار المساء',
      channelDescription: 'تذكير بأذكار المساء',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.zonedSchedule(
      1,
      title,
      body,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    logger.i(
      'Scheduled evening reminder at $hour:$minute',
      tag: 'NotificationService',
    );
  }

  Future<void> cancelMorningReminder() async {
    await _plugin.cancel(0);
  }

  Future<void> cancelEveningReminder() async {
    await _plugin.cancel(1);
  }

  Future<void> cancelAllReminders() async {
    await _plugin.cancelAll();
    logger.i('All reminders cancelled', tag: 'NotificationService');
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> scheduleRemindersFromSettings({
    required bool enabled,
    required String morningTime,
    required String eveningTime,
  }) async {
    if (!enabled) {
      await cancelAllReminders();
      return;
    }

    final morningParts = morningTime.split(':');
    final eveningParts = eveningTime.split(':');

    final morningHour = int.tryParse(morningParts[0]) ?? 6;
    final morningMinute =
        int.tryParse(morningParts.length > 1 ? morningParts[1] : '0') ?? 0;
    final eveningHour = int.tryParse(eveningParts[0]) ?? 18;
    final eveningMinute =
        int.tryParse(eveningParts.length > 1 ? eveningParts[1] : '0') ?? 0;

    await scheduleMorningReminder(
      hour: morningHour,
      minute: morningMinute,
      title: 'أذكار الصباح ☀️',
      body: 'لا تنسَ أذكار الصباح، ابدأ يومك بذكر الله',
    );

    await scheduleEveningReminder(
      hour: eveningHour,
      minute: eveningMinute,
      title: 'أذكار المساء 🌙',
      body: 'لا تنسَ أذكار المساء، حصّن نفسك بذكر الله',
    );
  }
}
