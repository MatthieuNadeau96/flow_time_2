import 'package:flow_time_2/bloc/timer/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final int duration = context.select(
      (TimerBloc bloc) => bloc.state.duration,
    );

    final double durationValue = context.select(
      (TimerBloc bloc) => doubleConverter(
        duration.toDouble(),
        bloc.isBreak ? bloc.breakDuration : bloc.workDuration,
      ),
    );

    return Stack(
      children: [
        SizedBox(
          height: 250,
          width: 250,
          child: LiquidCircularProgressIndicator(
            value: durationValue + durationValue * 0.1,
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation(Colors.lightBlue.shade200),
            borderColor: Colors.transparent,
            borderWidth: 0,
            direction: Axis.vertical,
            center: const TimerText(),
          ),
        ),
        SizedBox(
          height: 250,
          width: 250,
          child: LiquidCircularProgressIndicator(
            value: durationValue,
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation(Colors.blue.shade700),
            borderColor: Colors.transparent,
            borderWidth: 0,
            direction: Axis.vertical,
            center: const TimerText(),
          ),
        )
      ],
    );
  }

  double doubleConverter(double d, int time) => d / time;
}

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondStr = (duration % 60).floor().toString().padLeft(2, '0');

    return Text(
      '$minutesStr:$secondStr',
      style: Theme.of(context).textTheme.headline3,
    );
  }
}
