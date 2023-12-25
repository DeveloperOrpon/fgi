import 'dart:async';

import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../config/helper/helperFunction.dart';
import 'notification/model/fstore_notification_item.dart';
import 'notification/notification_service.dart';

const _topicAll = 'all-notifications';

class FirebaseNotificationService {
  final _instance = FirebaseMessaging.instance;

  StreamSubscription? _notificationSubscription;

  // @override
  // Future<bool> requestPermission() async {
  //   try {
  //     final result = await _instance.requestPermission();
  //     return result.alert == AppleNotificationSetting.enabled;
  //   } catch (_) {
  //     return false;
  //   }
  // }

  Future<void> init() async {
    final startTime = DateTime.now();
    final authController=Get.put(AuthenticationController());
    await _instance.getToken().then((token) async {
      authController.FCM=token!;
      printLog('[FirebaseCloudMessaging] init FCM token $token');
    });

    await _instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    await _instance.subscribeToTopic('all-notifications');

    final initMessage = await _instance.getInitialMessage();
    if (initMessage != null) {
      FirebaseMessaging.onMessageOpenedApp.listen((event) {

      });
      // FirebaseMessaging.onMessageOpenedApp(RSNotificationItem(
      //   id: initMessage.messageId ?? '',
      //   title: initMessage.notification?.title ?? '',
      //   body: initMessage.notification?.body ?? '',
      //   additionalData: initMessage.data,
      //   date: DateTime.now(),
      // ));
    }

    _notificationSubscription = FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        final notification = message.notification;
        final android = message.notification?.android;
        // if (notification != null && android != null && isAndroid) {
        //   flutterLocalNotificationsPlugin.show(
        //     notification.hashCode,
        //     notification.title,
        //     notification.body,
        //     NotificationDetails(
        //       android: AndroidNotificationDetails(
        //         channel.id,
        //         channel.name,
        //         channelDescription: channel.description,
        //         icon: android.smallIcon,
        //         // other properties...
        //       ),
        //       iOS: const DarwinNotificationDetails(),
        //     ),
        //     // payload: 'Notification'
        //   );
        // }

        // if (notification != null && android != null && true) {
        //   delegate.onMessage(RSNotificationItem(
        //     id: message.messageId ?? '',
        //     title: message.notification?.title ?? '',
        //     body: message.notification?.body ?? '',
        //     additionalData: message.data,
        //     date: DateTime.now(),
        //   ));
        // }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // printLog('Notification OpenedApp triggered');
      // delegate.onMessageOpenedApp(RSNotificationItem(
      //   id: message.messageId ?? '',
      //   title: message.notification?.title ?? '',
      //   body: message.notification?.body ?? '',
      //   additionalData: message.data,
      //   date: DateTime.now(),
      // ));
    });
  }

  // @override
  // void disableNotification() {
  //   _instance.unsubscribeFromTopic(_topicAll);
  //   _instance.setForegroundNotificationPresentationOptions(
  //     alert: false, // Required to display a heads up notification
  //     badge: false,
  //     sound: false,
  //   );
  //   if (_notificationSubscription != null) {
  //     _notificationSubscription!.pause();
  //   }
  // }
  //
  // @override
  // void enableNotification() {
  //   _instance.subscribeToTopic(_topicAll);
  //   _instance.setForegroundNotificationPresentationOptions(
  //     alert: true, // Required to display a heads up notification
  //     badge: true,
  //     sound: true,
  //   );
  //   if (_notificationSubscription != null) {
  //     _notificationSubscription!.resume();
  //   }
  // }
  //
  // @override
  // void setExternalId(String? userId) {}
  //
  // @override
  // void removeExternalId() {}
}
