import 'dart:async';
import 'package:flutter/material.dart';

class TimerHandler extends ChangeNotifier {
  int _seconds = 0;
  Timer? _timer;

  String get time {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void resetTimer({required int duration}) {
    _timer?.cancel();
    _seconds = duration;
    notifyListeners();
  }

  void startTimer({required int duration}) {
    _seconds = duration;
    notifyListeners();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    notifyListeners();
  }
}
