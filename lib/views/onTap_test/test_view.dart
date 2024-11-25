import 'package:flutter/material.dart';
import 'package:flutter_local_notification/views/onTap_test/widgets/test_view_body.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TestView extends StatelessWidget {
  const TestView({super.key, required this.notificationResponse});

  final NotificationResponse notificationResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TestViewBody(
        notificationResponse: notificationResponse,
      ),
    );
  }
}
