part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerInitialized extends TimerEvent {
  const TimerInitialized({required this.duration});
  final int duration;
}

class TimerStarted extends TimerEvent {
  const TimerStarted({required this.duration});
  final int duration;
}

class TimerPaused extends TimerEvent {
  const TimerPaused();
}

class TimerResumed extends TimerEvent {
  const TimerResumed();
}

class TimerStopped extends TimerEvent {
  const TimerStopped();
}

class TimerSkipped extends TimerEvent {
  const TimerSkipped();
}

class TimerTicked extends TimerEvent {
  const TimerTicked({required this.duration});
  final int duration;

  @override
  List<Object> get props => [duration];
}

class TimerComplete extends TimerEvent {
  const TimerComplete();
}
