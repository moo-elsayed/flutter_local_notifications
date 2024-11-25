import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notification/views/Home_View/widgets/home_view_body.dart';
import 'package:flutter_local_notification/views/onTap_test/test_view.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';
import '../../services/local_notification_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    listenToNotificationStream();
    handleAppLaunchFromNotification();
  }

  /// Listens to notification stream for real-time notification taps
  void listenToNotificationStream() {
    LocalNotificationService.streamController.stream.listen(
      (details) {
        _navigateToScreen(details);
      },
    );
  }

  /// Handles app launch via a notification
  Future<void> handleAppLaunchFromNotification() async {
    final NotificationAppLaunchDetails? launchDetails =
        await LocalNotificationService.flutterLocalNotificationsPlugin
            .getNotificationAppLaunchDetails();

    if (launchDetails?.didNotificationLaunchApp ?? false) {
      final notificationResponse = launchDetails!.notificationResponse;
      if (notificationResponse != null) {
        _navigateToScreen(notificationResponse);
      }
    }
  }

  /// Navigates to the appropriate screen
  void _navigateToScreen(NotificationResponse details) {
    log('Notification ID: ${details.id}');
    log('Notification Payload: ${details.payload}');

    navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (context) => TestView(
        notificationResponse: details,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.notifications),
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: const Text('Flutter Local Notification'),
      ),
      body: const HomeViewBody(),
    );
  }
}
