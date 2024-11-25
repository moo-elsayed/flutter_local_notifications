import 'package:flutter/material.dart';
import 'package:flutter_local_notification/services/local_notification_service.dart';
import 'package:flutter_local_notification/views/Home_View/home_view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.init();
  await LocalNotificationService.requestPermissions();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomeView(),
      ),
    );
  }
}
