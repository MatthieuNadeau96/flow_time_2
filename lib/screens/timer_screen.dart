import 'package:flow_time_2/widgets/action_buttons.dart';
import 'package:flow_time_2/widgets/ticker.dart';
import 'package:flow_time_2/widgets/timer_display.dart';
import 'package:flutter/material.dart';
import 'package:flow_time_2/bloc/timer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: const Ticker()),
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Center(child: TimerDisplay()),
              ),
              ActionButtons()
            ],
          )
        ],
      ),
    );
  }
}
