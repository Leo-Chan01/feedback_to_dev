import 'dart:developer';

import 'package:flutter/foundation.dart';

void kLogs(
  Object message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  String name = '',
  Object? error,
  StackTrace? stackTrace,
}) {
  if (kDebugMode) {
    log(
      message.toString(),
      time: time,
      sequenceNumber: sequenceNumber,
      level: level,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
