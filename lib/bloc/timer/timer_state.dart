part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  const TimerState(this.duration);
  final int duration;

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial(super.duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

class TimerReInitialized extends TimerState {
  const TimerReInitialized(super.duration);

  @override
  String toString() => 'TimerReInitialized { duration: $duration }';
}

class TimerRunPause extends TimerState {
  const TimerRunPause(super.duration);

  @override
  String toString() => 'TimerRunPause { duration: $duration }';
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.duration);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

class TimerRunComplete extends TimerState {
  @override
  String toString() => 'TimerRunComplete!';
  const TimerRunComplete() : super(0);
}
