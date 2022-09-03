import 'package:flow_time_2/models/color.dart';
import 'package:flow_time_2/provider/preference_provider.dart';
import 'package:flow_time_2/screens/settings_screen.dart';
import 'package:flow_time_2/screens/timer_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PreferenceProvider(),
      child: Consumer<PreferenceProvider>(
        builder: (context, provider, child) {
          return StreamBuilder<Brightness>(
              stream: provider.bloc.brightness,
              builder: (context, snapshotBrightness) {
                return StreamBuilder<ColorModel>(
                    stream: provider.bloc.primaryColor,
                    builder: (context, snapshotColor) {
                      print("->> ${snapshotColor.data?.color}");
                      return MaterialApp(
                        title: 'Flow Time',
                        theme: ThemeData(
                          brightness:
                              snapshotBrightness.data ?? Brightness.light,
                          primaryColor:
                              snapshotColor.data?.color ?? Colors.blue,
                        ),
                        // home: const TimerScreen(),
                        routes: {
                          '/': ((context) => const TimerScreen()),
                          '/settings': ((context) => const SettingsScreen()),
                        },
                      );
                    });
              });
        },
      ),
    );
  }
}
