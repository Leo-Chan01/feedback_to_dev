import 'package:equatable/equatable.dart';

class TimerState extends Equatable {
  const TimerState({required this.seconds, this.isRunning = false});
  final int seconds;
  final bool isRunning;

  @override
  List<Object?> get props => [seconds, isRunning];
}
