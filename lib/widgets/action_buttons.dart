import 'package:flow_time_2/bloc/timer_bloc.dart';
import 'package:flow_time_2/widgets/circular_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (state is TimerInitial) ...[
              CircularButton(
                icon: const Icon(
                  Icons.play_arrow,
                  size: 60,
                ),
                onTap: () => context
                    .read<TimerBloc>()
                    .add(TimerStarted(duration: state.duration)),
                onLongTap: () {},
              )
            ],
            if (state is TimerRunInProgress) ...[
              CircularButton(
                icon: const Icon(
                  Icons.pause,
                  size: 60,
                ),
                onTap: () => context.read<TimerBloc>().add(const TimerPaused()),
                onLongTap: () {},
              )
            ],
            if (state is TimerRunPause) ...[
              CircularButton(
                icon: const Icon(
                  Icons.play_arrow,
                  size: 60,
                ),
                onTap: () =>
                    context.read<TimerBloc>().add(const TimerResumed()),
                onLongTap: () {},
              )
            ],
            if (state is TimerRunComplete) ...[
              CircularButton(
                icon: const Icon(
                  Icons.replay,
                  size: 60,
                ),
                onTap: () => context.read<TimerBloc>().add(const TimerReset()),
                onLongTap: () {},
              )
            ],
          ],
        );
      },
    );
  }
}
