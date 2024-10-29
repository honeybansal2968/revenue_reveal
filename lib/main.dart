import 'package:flutter/material.dart';
import 'package:revenue_reveal/modules/homePage/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Earnings Tracker',
      theme: ThemeData(useMaterial3: true),
      home: HomeScreen(),
    );
  }
}
