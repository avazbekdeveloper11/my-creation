import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../firebase_options.dart';

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
InitializationSettings initializationSettings = const InitializationSettings(
  android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  iOS: DarwinInitializationSettings(),
);

sealed class NotificationService {
  const NotificationService._();

  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await setupFlutterNotifications();
    await foregroundNotification();
    backgroundNotification();
    await terminateNotification();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> setupFlutterNotifications() async {
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.requestPermission(
        criticalAlert: true,
        announcement: true,
        provisional: true,
      );
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static void showFlutterNotification(RemoteMessage message) {
    final bool notificationIsNotEmpty = (message.notification?.title?.isNotEmpty ?? false);
    final bool messageIsNotEmpty = message.data.isNotEmpty;
    if (notificationIsNotEmpty || messageIsNotEmpty && !kIsWeb) {
      unawaited(
        flutterLocalNotificationsPlugin.show(
          message.hashCode,
          messageIsNotEmpty ? message.data['title'] : message.notification?.title,
          messageIsNotEmpty ? message.data['body'] : message.notification?.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              styleInformation: BigTextStyleInformation(
                messageIsNotEmpty ? message.data['body'] ?? '' : message.notification?.body,
                contentTitle: messageIsNotEmpty ? message.data['title'] : message.notification?.title,
              ),
              icon: '@mipmap/ic_launcher',
              priority: Priority.high,
              importance: Importance.high,
              visibility: NotificationVisibility.public,
              enableLights: true,
              enableVibration: true,
              playSound: true,
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              sound: 'default',
            ),
          ),
          payload: message.data['route'],
        ),
      );
    }
  }

  static Future<void> foregroundNotification() async {
    FirebaseMessaging.onMessage.listen((v) => showFlutterNotification(v));

    ///When tapped
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) async {
        debugPrint('foreground notification tapped');
        debugPrint('$response');
      },
    );
  }

  static void backgroundNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (v) => showFlutterNotification(v),
    );
  }

  static Future<void> terminateNotification() async {
    final remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage == null) {
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );
    } else {
      showFlutterNotification(remoteMessage);
    }
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.setupFlutterNotifications();

  NotificationService.showFlutterNotification(message);
}
