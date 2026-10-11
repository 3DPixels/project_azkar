import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // Initialize the notification service
  Future<void> init() async {
    tz.initializeTimeZones();
    final tzInfo = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(tzInfo.identifier));

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@drawable/ic_notification');
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _plugin.initialize(settings: settings);
  }

  /// Quietly checks if notification permissions are granted without prompting dialogs.
  Future<bool> checkPermissions() async {
    final androidImplementation = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidImplementation != null) {
      final enabled = await androidImplementation.areNotificationsEnabled();
      return enabled ?? false;
    }
    return false;
  }

  /// Prompts the user with the system permission dialog.
  Future<bool> requestPermissions() async {
    final androidImplementation = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidImplementation != null) {
      final notifResult = await androidImplementation
          .requestNotificationsPermission();
      return notifResult ?? false;
    }
    return false;
  }

  Future<void> cancel(int id) async => await _plugin.cancel(id: id);

  Future<void> cancelRange(int startId, int endId) async {
    for (int i = startId; i <= endId; i++) {
      await _plugin.cancel(id: i);
    }
  }

  Future<void> scheduleZoned({
    String? title,
    String? body,
    required int id,
    required DateTime time,
  }) async {
    if (time.isBefore(DateTime.now())) return;

    final tzTime = tz.TZDateTime.from(time, tz.local);

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tzTime,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_channel',
          'مواقيت الصلاة و اذكار يومية',
          groupKey: 'dalil_almuslim_group',
          importance: Importance.max,
          priority: Priority.max,
          category: AndroidNotificationCategory.reminder,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> scheduleRepeating({
    String? title,
    String? body,
    required int id,
  }) async {
    await _plugin.periodicallyShow(
      id: id,
      title: title,
      body: body,
      repeatInterval: RepeatInterval.hourly,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'hourly_azkar',
          'أذكار متكررة',
          groupKey: 'dalil_almuslim_group',
          category: AndroidNotificationCategory.reminder,
          playSound: false,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexact,
    );
  }

  Future<void> showNotification() async {
    await _plugin.show(
      id: 0,
      title: 'title',
      body: 'body',
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'hourly_azkar',
          'أذكار متكررة',
          groupKey: 'dalil_almuslim_group',
          category: AndroidNotificationCategory.reminder,
          playSound: false,
        ),
      ),
    );
  }
}
