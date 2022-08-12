import 'package:flow_time_2/widgets/action_buttons.dart';
import 'package:flow_time_2/widgets/ticker.dart';
import 'package:flow_time_2/widgets/timer_display.dart';
import 'package:flutter/material.dart';
import 'package:flow_time_2/bloc/timer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    degOneTranslationAnimation =
        Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));
    animationController.addListener(() {
      setState(() {});
    });
  }

  late AnimationController animationController;
  late Animation degOneTranslationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: const Ticker()),
      child: TimerView(
        animation: degOneTranslationAnimation,
        animationController: animationController,
        radiansFromDegree: getRadiansFromDegree,
      ),
    );
  }
}

class TimerView extends StatelessWidget {
  final Animation animation;
  final AnimationController animationController;
  final Function radiansFromDegree;
  const TimerView({
    super.key,
    required this.animation,
    required this.animationController,
    required this.radiansFromDegree,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Center(child: TimerDisplay()),
              ),
              ActionButtons(
                animationController: animationController,
                animation: animation,
                radiansFromDegree: radiansFromDegree,
              )
            ],
          )
        ],
      ),
    );
  }
}
