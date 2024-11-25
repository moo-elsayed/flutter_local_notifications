import 'package:flutter/material.dart';
import 'package:flutter_local_notification/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TestViewBody extends StatelessWidget {
  const TestViewBody({super.key, required this.notificationResponse});

  final NotificationResponse notificationResponse;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Hello',
            style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'You came from ${notificationResponse.payload} Notification, didn\'t you?'),
            ],
          ),
        ],
      ),
    );
  }
}
