// import 'dart:developer';
// import 'dart:math' as Math;
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
// import '../main.dart';
//
// class LocalNotification {
//   LocalNotification() {
//     init();
//   }
//
//   init() async {
//     {
//       await FirebaseMessaging.instance.subscribeToTopic('all_user');
//       await FirebaseMessaging.instance.subscribeToTopic('newProduct');
//       FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//       NotificationSettings settings = await messaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         // criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//       final fcmToken = await FirebaseMessaging.instance.getToken();
//       FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//       FirebaseMessaging.onMessage.listen((event) {
//         log("message");
//         createNotification(event);
//       });
//       // configFcm();
//       log("FCMToken : $fcmToken");
//
//       ///Awesome notification
//       await AwesomeNotifications().initialize(
//         'resource://drawable/icon',
//         [
//           NotificationChannel(
//             icon: 'resource://drawable/icon',
//             playSound: true,
//             channelKey: 'importance_channel',
//             channelName: 'High Importance Notifications',
//             channelDescription: "awesome Description",
//             enableVibration: true,
//             locked: true,
//             ledColor: Colors.orange,
//
//             defaultRingtoneType: DefaultRingtoneType.Notification,
//             importance: NotificationImportance.Max,
//           ),
//         ],
//         debug: true,
//       );
//
//     }
//   }
// }
// createNotification(RemoteMessage m) async {
//   int uniqueId = Math.Random().nextInt(20);
//   log("In Notification Method : $uniqueId");
//   log("${m.data}");
//   if (m.data.isEmpty || m.data['type'] != null && m.data['type']!=null) {
//     log("Message Come In");
//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: uniqueId,
//           groupKey: 'jhonny_group',
//           channelKey: 'importance_channel',
//           summary: "Message Conversation",
//           title: m.data['title']??m.notification==null?"New Notification":m.notification!.title,
//           body: m.data['message']??m.notification==null?"New Notification":m.notification!.body,
//           actionType: ActionType.Default,
//         ),
//         actionButtons: [
//           NotificationActionButton(
//             key: 'REPLY',
//             label: 'Reply',
//             autoDismissible: false,
//           ),
//           NotificationActionButton(
//             key: 'READ',
//             label: 'Mark as Read',
//             autoDismissible: true,
//           )
//         ]
//     );
//   } else {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//           largeIcon: m.data['image'],
//           color: Colors.amber,
//           backgroundColor: Colors.red,
//           id: uniqueId,
//           channelKey: 'importance_channel',
//           title: m.data['title'],
//           body: m.data['message'],
//           notificationLayout: NotificationLayout.BigPicture,
//           bigPicture: m.data['image'],
//           payload: {"name": "flutter"}),
//       actionButtons: [
//         NotificationActionButton(
//           key: 'MARK_DONE',
//           label: 'Open',
//           color: Colors.red,
//         )
//       ],
//     );
//   }
// }