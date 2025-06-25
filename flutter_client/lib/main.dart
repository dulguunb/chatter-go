import 'package:flutter/material.dart';
import 'widgets/landing_page_login.dart';

void main() {
  runApp(const MainApp());
}



class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Meow Meow chat';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        // #docregion add-widget
        body: const SingleChildScrollView(
          child: Column(
            children: [
              LandingPageForum(),
            ],
          ),
        ),
        // #enddocregion add-widget
      ),
    );
  }
}
