import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_time_2/widgets/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  bool isBreak = false;

  static int _duration = (55);
  int newDuration = _duration;
  int flowDuration = (69);
  int breakDuration = (420);

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(TimerInitial(
          _duration,
        )) {
    on<TimerInitialized>(_onInitialized);
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

  void _onInitialized(TimerInitialized event, Emitter<TimerState> emit) async {
    checkDuration();
    _tickerSubscription?.cancel();
    print('the new duration IS!!!!!!! -. $newDuration');
    emit(TimerReInitialized(newDuration));
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    checkDuration();
    emit(TimerRunInProgress(newDuration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: newDuration)
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
    checkDuration();
    _tickerSubscription?.cancel();
    emit(TimerInitial(newDuration));
  }

  void _onSkipped(TimerSkipped event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();

    isBreak = !isBreak;

    checkDuration();

    emit(TimerInitial(newDuration));
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    checkDuration();
    emit(event.duration > 0
        ? TimerRunInProgress(event.duration)
        : const TimerRunComplete());
  }

  void _onComplete(TimerComplete event, Emitter<TimerState> emit) {
    print('END');
    isBreak ? print('TIME TO FLOW') : print('TIME FOR A BREAK');
    _tickerSubscription?.cancel();
    isBreak = !isBreak;
    // TODO Sound the alarm
    // TODO Push notification

    checkDuration();
    emit(TimerInitial(newDuration));
  }

  Future<int> checkDuration() async {
    return _duration = newDuration;
  }
}
