// Timer Bloc
// ignore_for_file: avoid_redundant_argument_values

import 'dart:async';

import 'package:feedback_to_vfd/core/presentation/bloc/timer_events.dart';
import 'package:feedback_to_vfd/core/presentation/bloc/timer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(const TimerState(seconds: 0)) {
    on<StartTimer>(_onStartTimer);
    on<TickTimer>(_onTickTimer);
    on<StopTimer>(_onStopTimer);
    on<ResetTimer>(_onResetTimer);
  }
  Timer? _timer;

  void _onStartTimer(StartTimer event, Emitter<TimerState> emit) {
    _timer?.cancel();
    emit(TimerState(seconds: event.duration, isRunning: true));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(TickTimer());
    });
  }

  void _onTickTimer(TickTimer event, Emitter<TimerState> emit) {
    if (state.seconds > 0) {
      emit(TimerState(seconds: state.seconds - 1, isRunning: true));
    } else {
      _timer?.cancel();
      emit(const TimerState(seconds: 0, isRunning: false));
    }
  }

  void _onStopTimer(StopTimer event, Emitter<TimerState> emit) {
    _timer?.cancel();
    emit(TimerState(seconds: state.seconds, isRunning: false));
  }

  void _onResetTimer(ResetTimer event, Emitter<TimerState> emit) {
    _timer?.cancel();
    emit(TimerState(seconds: event.duration, isRunning: false));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
