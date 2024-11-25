import 'package:flutter/material.dart';
import 'package:flutter_local_notification/views/Home_View/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
