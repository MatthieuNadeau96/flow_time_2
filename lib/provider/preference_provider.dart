import 'package:flow_time_2/bloc/preference/preference_bloc.dart';
import 'package:flutter/material.dart';

class PreferenceProvider with ChangeNotifier {
  late PreferenceBloc _bloc;

  PreferenceProvider() {
    _bloc = PreferenceBloc();
    _bloc.loadPreferences();
  }

  PreferenceBloc get bloc => _bloc;
}
