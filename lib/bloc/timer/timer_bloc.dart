import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_time_2/widgets/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  bool isBreak = false;
  static int _duration = 60;
  final int workDuration = 60;
  final int breakDuration = 30;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerStopped>(_onStopped);
    on<TimerSkipped>(_onSkipped);
    on<TimerTicked>(_onTicked);
    on<TimerComplete>(_onComplete);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    checkDuration();
    emit(TimerRunInProgress(_duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: _duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  void _onResumed(TimerResumed event, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  void _onStopped(TimerStopped event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      checkDuration();
      _tickerSubscription?.cancel();
      emit(TimerInitial(_duration));
    }
  }

  void _onSkipped(TimerSkipped event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();

    isBreak = !isBreak;

    checkDuration();

    emit(TimerInitial(_duration));
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    checkDuration();
    emit(event.duration > 0
        ? TimerRunInProgress(event.duration)
        : const TimerRunComplete());
  }

  void _onComplete(TimerComplete event, Emitter<TimerState> emit) {
    isBreak = !isBreak;
    // TODO
  }

  int checkDuration() {
    return _duration = isBreak ? breakDuration : workDuration;
  }
}
