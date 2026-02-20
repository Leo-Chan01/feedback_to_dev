// ignore_for_file: unawaited_futures

import 'package:feedback_to_vfd/core/utils/custom_log_file.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationService {
  NotificationService._internal();
  static final NotificationService _notificationService =
      NotificationService._internal();

  static NotificationService get instance => _notificationService;

  AndroidNotificationChannel androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications({bool isDev = false}) async {
    // Only enable debug logging in development mode
    if (isDev) {
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    }

    OneSignal.initialize('e4053b50-f0e0-4d4f-8f44-76edf1060f8f');
    Future<void>.delayed(const Duration(milliseconds: 100));
    OneSignal.Notifications.requestPermission(true);
    OneSignal.User.pushSubscription.optIn();

    OneSignal.User.addObserver((state) {
      final userState = state.jsonRepresentation();
      kLogs('OneSignal user changed: $userState');
    });

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestProvisionalPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(settings: initSettings);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidChannel);

    OneSignal.Notifications.addForegroundWillDisplayListener((
      event,
    ) {
      // Handle incoming push notification and show using
      //Flutter Local Notifications
      _showLocalNotification(event.notification.title, event.notification.body);
    });

    OneSignal.Notifications.addClickListener((event) {
      kLogs('Notification clicked: ${event.notification.title}');
    });

    await OneSignal.Notifications.lifecycleInit();
  }

  Future<void> _showLocalNotification(String? title, String? body) async {
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const generalNotificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await FlutterLocalNotificationsPlugin().show(
      id: 0,
      title: title,
      body: body,
      notificationDetails: generalNotificationDetails,
    );
  }
}
