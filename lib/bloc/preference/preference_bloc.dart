import 'package:flow_time_2/models/color.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceBloc {
  final _brightness = BehaviorSubject<Brightness>();
  final _primaryColor = BehaviorSubject<ColorModel>();
  final _colors = [
    ColorModel(index: 0.0, color: Colors.blue, name: 'Blue'),
    ColorModel(index: 1.0, color: Colors.green, name: 'Green'),
    ColorModel(index: 2.0, color: Colors.red, name: 'Red'),
    ColorModel(index: 3.0, color: Colors.purple, name: 'Purple'),
  ];

  // Getters
  Stream<Brightness> get brightness => _brightness.stream;
  Stream<ColorModel> get primaryColor => _primaryColor.stream;

  // Setters
  Function(Brightness) get changeBrightness => _brightness.sink.add;
  Function(ColorModel) get changePrimaryColor => _primaryColor.sink.add;

  indexToPrimaryColor(double index) {
    return _colors.firstWhere((e) => e.index == index);
  }

  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_brightness.value == Brightness.light) {
      await prefs.setBool('dark', false);
    } else {
      await prefs.setBool('dark', true);
    }

    await prefs.setDouble('colorIndex', _primaryColor.value.index);
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? darkMode = prefs.getBool('dark');
    double? colorIndex = prefs.getDouble('colorIndex');

    if (darkMode != null) {
      (darkMode == false)
          ? changeBrightness(Brightness.light)
          : changeBrightness(Brightness.dark);
    } else {
      changeBrightness(Brightness.light);
    }

    if (colorIndex != null) {
      changePrimaryColor(indexToPrimaryColor(colorIndex));
    } else {
      changePrimaryColor(
        ColorModel(index: 0.0, color: Colors.blue, name: 'Blue'),
      );
    }
  }

  dispose() {
    _primaryColor.close();
    _brightness.close();
  }
}
