// ignore_for_file: avoid_print

import 'package:flow_time_2/bloc/timer/timer_bloc.dart';
import 'package:flow_time_2/provider/preference_provider.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final int duration = context.select(
      (TimerBloc bloc) => bloc.state.duration,
    );

    final bool isBreak = context.select(
      (TimerBloc bloc) => bloc.isBreak,
    );

    return ChangeNotifierProvider(
      create: (BuildContext context) => PreferenceProvider(),
      child: Consumer<PreferenceProvider>(
        builder: (context, provider, child) {
          final Stream<int> dataStream = isBreak
              ? provider.bloc.breakDuration
              : provider.bloc.flowDuration;
          return StreamBuilder<int>(
              stream: dataStream,
              builder: (context, snapshot) {
                isBreak ? print('streaming BREAK') : print('streaming FLOW');
                print('snapshot data >>> ${snapshot.data} mins');
                if (!snapshot.hasData) {
                  print('no data no data no data no data');
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  print(
                      '------------------HAS DATA NOW ----------------------');
                  int dur = snapshot.data ?? 0;
                  print('dur--$dur');
                  context.select(
                    (TimerBloc bloc) => bloc.newDuration = dur,
                  );

                  final double durationValue = context.select(
                    (TimerBloc bloc) => doubleConverter(
                      duration.toDouble(),
                      bloc.newDuration = dur,
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
                          valueColor:
                              AlwaysStoppedAnimation(Colors.lightBlue.shade200),
                          borderColor: Colors.transparent,
                          borderWidth: 0,
                          direction: Axis.vertical,
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        width: 250,
                        child: LiquidCircularProgressIndicator(
                          value: durationValue,
                          backgroundColor: Colors.transparent,
                          valueColor:
                              AlwaysStoppedAnimation(Colors.blue.shade700),
                          borderColor: Colors.transparent,
                          borderWidth: 0,
                          direction: Axis.vertical,
                          center: const TimerText(),
                        ),
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
        },
      ),
    );
  }

  double doubleConverter(double d, int time) => d / time;
}

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    print('TimerText bloc.state.duration -> $duration');
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondStr = (duration % 60).floor().toString().padLeft(2, '0');

    return Text(
      '$minutesStr:$secondStr',
      style: Theme.of(context).textTheme.headline3,
    );
  }
}
