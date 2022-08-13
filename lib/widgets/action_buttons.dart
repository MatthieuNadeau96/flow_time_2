import 'package:flow_time_2/bloc/timer_bloc.dart';
import 'package:flow_time_2/widgets/circular_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionButtons extends StatelessWidget {
  final Animation animation;
  final AnimationController animationController;
  final Function radiansFromDegree;

  const ActionButtons({
    super.key,
    required this.animation,
    required this.animationController,
    required this.radiansFromDegree,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        return Stack(
          children: [
            Transform.translate(
              offset: Offset.fromDirection(
                radiansFromDegree(0.0),
                animation.value * 100,
              ),
              child: Transform.scale(
                scale: animation.value,
                child: SizedBox(
                  height: 117,
                  child: CircularButton(
                    height: 50,
                    width: 50,
                    icon: const Icon(Icons.skip_next),
                    onTap: () =>
                        context.read<TimerBloc>().add(const TimerSkipped()),
                    onLongTap: () {},
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset.fromDirection(
                radiansFromDegree(180.0),
                animation.value * 100,
              ),
              child: Transform.scale(
                scale: animation.value,
                child: SizedBox(
                  height: 117,
                  child: CircularButton(
                    height: 50,
                    width: 50,
                    icon: const Icon(Icons.stop),
                    onTap: () =>
                        context.read<TimerBloc>().add(const TimerStopped()),
                    onLongTap: () {},
                  ),
                ),
              ),
            ),
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if (state is TimerInitial) ...[
              CircularButton(
                icon: const Icon(
                  Icons.play_arrow,
                  size: 60,
                ),
                onTap: () => context
                    .read<TimerBloc>()
                    .add(TimerStarted(duration: state.duration)),
                onLongTap: () {
                  if (animationController.isCompleted) {
                    animationController.reverse();
                  } else {
                    animationController.forward();
                  }
                },
              )
            ],
            if (state is TimerRunInProgress) ...[
              CircularButton(
                icon: const Icon(
                  Icons.pause,
                  size: 60,
                ),
                onTap: () => context.read<TimerBloc>().add(const TimerPaused()),
                onLongTap: () {
                  if (animationController.isCompleted) {
                    animationController.reverse();
                  } else {
                    animationController.forward();
                  }
                },
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
                onLongTap: () {
                  if (animationController.isCompleted) {
                    animationController.reverse();
                  } else {
                    animationController.forward();
                  }
                },
              )
            ],
            if (state is TimerRunComplete) ...[
              CircularButton(
                icon: const Icon(
                  Icons.replay,
                  size: 60,
                ),
                onTap: () =>
                    context.read<TimerBloc>().add(const TimerStopped()),
                onLongTap: () {
                  if (animationController.isCompleted) {
                    animationController.reverse();
                  } else {
                    animationController.forward();
                  }
                },
              )
            ],
          ],
        );
      },
    );
  }
}
