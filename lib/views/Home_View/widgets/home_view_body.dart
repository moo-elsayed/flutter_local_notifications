import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notification/services/local_notification_service.dart';
import 'package:flutter_local_notification/views/Home_View/widgets/custom_button.dart';

import 'custom_list_tile.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomListTile(
          onTap: () {
            LocalNotificationService.showBasicNotification();
          },
          notificationType: 'Basic Notification',
          onCancelTap: () {
            LocalNotificationService.cancelNotification(id: 0);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Canceled'),
              ),
            );
          },
        ),
        CustomListTile(
          onTap: () {
            LocalNotificationService.showRepeatedNotification();
          },
          notificationType: 'Repeated Notification',
          onCancelTap: () {
            LocalNotificationService.cancelNotification(id: 1);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Canceled'),
              ),
            );
          },
        ),
        CustomListTile(
          onTap: () {
            LocalNotificationService.showScheduledNotification();
          },
          notificationType: 'Scheduled Notification',
          onCancelTap: () {
            LocalNotificationService.cancelNotification(id: 2);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Canceled'),
              ),
            );
          },
        ),
        const SizedBox(
          height: 15,
        ),
        CustomButton(
          color: Colors.red,
          label: 'Cancel all',
          on: () {
            LocalNotificationService.flutterLocalNotificationsPlugin
                .cancelAll();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Canceled'),
              ),
            );
          },
          textColor: Colors.white,
        ),
      ],
    );
  }
}
