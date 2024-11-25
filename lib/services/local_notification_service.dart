import 'dart:async';
import 'dart:developer';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static StreamController<NotificationResponse> streamController =
      StreamController();

  // 1.setup

  static onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  static Future<void> init() async {
    // Create the notification channel for Android 8.0 and above
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'basic_channel', // Channel ID
      'Basic Notifications', // Channel Name
      description: 'This channel is used for basic notifications',
      importance: Importance.high, // Set importance to high to ensure sound
      playSound: true, // Ensure sound is played
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: DarwinInitializationSettings());

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: onTap,
      onDidReceiveNotificationResponse: onTap,
    );

    // Create and register the notification channel for Android 8.0 and above
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Request notification permissions (needed for Android 13+ and iOS)
  static Future<void> requestPermissions() async {
    // Request permissions for Android (API 33+)
    if (await Permission.notification.isDenied) {
      // Use permission_handler to request notification permission
      await Permission.notification.request();
    }

    // Check if notifications are enabled using flutter_local_notifications
    final androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation != null) {
      final isEnabled = await androidImplementation.areNotificationsEnabled();

      // Notify the user if notifications are disabled in settings
      if (isEnabled == false) {
        // Add logic to show a message to the user if notifications are disabled.
        log('Notifications are disabled in system settings.');
      }
    }
  }

  // 2.basic notification

  static void showBasicNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'basic_channel_2', // New unique Channel ID
      'Basic Notifications', // Channel Name
      channelDescription:
          'This channel is used for basic notifications with sound',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      // Ensure sound plays
      sound: RawResourceAndroidNotificationSound('notification_sound'),
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
        0, 'Basic Notification', 'body', notificationDetails,
        payload: 'basic');

    log('Notification displayed');
  }

  // 3.repeated notification

  static void showRepeatedNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'repeated_channel_2', // New unique Channel ID
      'Repeated Notifications', // Channel Name
      channelDescription: 'This channel is used for repeated notifications',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.periodicallyShow(
        1, // Notification ID (use a unique ID for each notification)
        'Repeated Notification', // Notification Title
        'body', // Notification Body
        RepeatInterval.everyMinute,
        // Repeat Interval (you can change this to everyMinute, everyHour, etc.)
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exact,
        payload:
            'repeated'); //Allow notification to show even when the app is in the background);

    log('Notification displayed');
  }

  // 4.scheduled notification

  static void showScheduledNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'scheduled_channel_3', // New unique Channel ID
      'scheduled Notifications', // Channel Name
      channelDescription: 'This channel is used for scheduled notifications',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    tz.initializeTimeZones();

    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    await flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        'scheduled Notification',
        'body',
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
        tz.TZDateTime(tz.local, 2024, 11, 25, 16, 59),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exact,
        payload: 'scheduled');

    log('Notification displayed');
    log('${tz.local}');
    log('${tz.TZDateTime.now(tz.local).hour}');
  }

  static void cancelNotification({required int id}) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}

// 1.setup
// 2.basic notification
// 3.repeated notification
// 4.scheduled notification
