import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartTimer extends TimerEvent {
  StartTimer({required this.duration});
  final int duration;

  @override
  List<Object?> get props => [duration];
}

class TickTimer extends TimerEvent {}

class StopTimer extends TimerEvent {}

class ResetTimer extends TimerEvent {
  ResetTimer({required this.duration});
  final int duration;

  @override
  List<Object?> get props => [duration];
}
