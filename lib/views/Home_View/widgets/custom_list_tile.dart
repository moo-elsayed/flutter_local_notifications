import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.onCancelTap,
      required this.notificationType,
      required this.onTap});

  final void Function() onCancelTap;
  final void Function() onTap;
  final String notificationType;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const Icon(
        Icons.notifications,
        color: Colors.amber,
      ),
      title: Text(notificationType),
      trailing: GestureDetector(
          onTap: onCancelTap,
          child: const Icon(
            Icons.cancel,
            color: Colors.red,
          )),
    );
  }
}
