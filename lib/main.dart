import 'package:flow_time_2/screens/timer_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flow Time',
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: const ColorScheme.light(secondary: Colors.red),
      ),
      home: const TimerScreen(),
    );
  }
}
