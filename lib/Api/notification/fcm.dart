import 'dart:developer';
import 'dart:math' as Math;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:fgi_y2j/features/notification/controller/notificationController.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart' as Get;
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../../config/helper/helperFunction.dart';
import '../../features/order/controller/orderController.dart';
import '../../main.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.max,
  ledColor: Colors.blue,
);

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

const MethodChannel platform =
    MethodChannel('orpon.dev/flutter_local_notifications_example');

class ReceivedNotification {
  ReceivedNotification({
    this.id,
    this.title,
    this.body,
    this.payload,
  });

  int? id;
  String? title;
  String? body;
  String? payload;
}

String? selectedNotificationPayload;

configFcm() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('notification_icon');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  NotificationSettings settings = await _firebaseMessaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  _firebaseMessaging.getToken().then((value) {
    log("fcm::  ${value!}");
  });

  await _firebaseMessaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  _firebaseMessaging.subscribeToTopic('USE');
  _firebaseMessaging.subscribeToTopic('GARAGE');
  _firebaseMessaging.subscribeToTopic('alluser');
  _firebaseMessaging.subscribeToTopic('newProductUser');
  // _firebaseMessaging.getInitialMessage().then((value){
  //   handleMessage(value!);
  // });

  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);


  ///Awesome notification
  AwesomeNotifications().initialize(
    'resource://drawable/logo',
    [
      NotificationChannel(
        icon: 'resource://drawable/logo',
        playSound: true,
        channelKey: 'importance_channel',
        channelName: 'High Importance Notifications',
        channelDescription: "awesome Description",
        //defaultColor: Colors.teal,
        locked: true,
        defaultRingtoneType: DefaultRingtoneType.Notification,
        importance: NotificationImportance.High,
        enableVibration: true,

      ),
    ],

    debug: true,
  );
  AwesomeNotifications().requestPermissionToSendNotifications();
  requestNotificationPermissions();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    printLog('Handling a onMessageOpenedApp message ${message.messageId}');
    printLog('Handling a onMessageOpenedApp message ${message.data}');
    createNotification(message);
  });
  FirebaseMessaging.onMessage.listen((message) {
    printLog('Handling a onMessage message ${message.messageId}');
    printLog('Handling a onMessage message ${message.data}');
    createNotification(message);
  });
  AwesomeNotifications().setListeners(onActionReceivedMethod: (receivedAction) async{
    log("onActionReceivedMethod");
    return ;
  },);
}
Future<void> requestNotificationPermissions() async {
  final PermissionStatus status = await Permission.notification.request();
  if (status.isGranted) {
    // Notification permissions granted
  } else if (status.isDenied) {
    // Notification permissions denied
  } else if (status.isPermanentlyDenied) {
    // Notification permissions permanently denied, open app settings
    await openAppSettings();
  }
}

createNotification(RemoteMessage m) async {
  int uniqueId = Math.Random().nextInt(20);
  log("In Notification Method : $uniqueId");
  log("${m.data}");
  if (m.data['type'] != null && m.data['type'] == 'Message') {
    log("Message Come In");
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: uniqueId,
            groupKey: 'jhonny_group',
            channelKey: 'importance_channel',
            summary: "Message Conversation",
            title: m.data['title'],
            body: m.data['message'],
            largeIcon: m.data['image'],
            criticalAlert: true,
            notificationLayout: NotificationLayout.Messaging,
            category: NotificationCategory.Message),
        actionButtons: [
          NotificationActionButton(
            key: 'REPLY',
            label: 'Reply',
            autoDismissible: false,
          ),
          NotificationActionButton(
            key: 'READ',
            label: 'Mark as Read',
            autoDismissible: true,
          )
        ]);
  } else {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          largeIcon: m.data['image'],
          color: Colors.amber,
          backgroundColor: Colors.red,
          id: uniqueId,
          channelKey: 'importance_channel',
          title: m.data['title'],
          body: m.data['message'],
          notificationLayout: NotificationLayout.BigPicture,
          bigPicture: m.data['image'],
          payload: {"name": "flutter"}),
      actionButtons: [
        NotificationActionButton(

          key: 'MARK_DONE',
          label: 'Open',
          color: Colors.red,

        ),

      ],

    );
  }
  var noti=Get.Get.put(AppNotificationController());
  final orderController = Get.Get.put(OrderController());
  noti.page=1;
  noti.notificationList.value=[];
  noti.getNotification();
  orderController.pendingOrderList.value=[];
  orderController.completedOrderList.value=[];
  orderController.acceptOrderList.value=[];
  orderController.pendingOrderInformation(1);
  orderController.completedOrderInformation(1);
  orderController.acceptOrderInformation(1);
}

Future<Response> sentNotificationWithImage(
    String title, String body, String url, String fcmToken) async {
  Map notificationMap = {
    "data": {"title": title, "image": url, "message": body},
    "to": fcmToken
  };
  log("Map : $notificationMap");
  Dio dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers["Authorization"] =
      "key=AAAAfLBUwv4:APA91bHeRkFIZUC6nfkYYCxIVEb5u_8gqXK5TwuqBnw9vlE9kz6AVOUrLWX-yvg1ku4pgxKrSlCjJOaPIagfwzKbcDUt6LhfP-ajUkZHZzGL-y-8VLr5qr2E-WFxQl_zRYHvDrirwHMz";
  Response response = await dio.post('https://fcm.googleapis.com/fcm/send',
      data: notificationMap);
  return response;
}

Future<Response> sentMessageNotification(String title, String body, String url,
    String fcmToken, String userId) async {
  Map notificationMap = {
    "data": {
      "title": title,
      "image": url,
      "message": body,
      "type": "Message",
      "userId": userId
    },
    "to": fcmToken
  };
  log("Map : $notificationMap : Fcm : ${fcmToken}");
  Dio dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers["Authorization"] =
      "key=AAAAfLBUwv4:APA91bHeRkFIZUC6nfkYYCxIVEb5u_8gqXK5TwuqBnw9vlE9kz6AVOUrLWX-yvg1ku4pgxKrSlCjJOaPIagfwzKbcDUt6LhfP-ajUkZHZzGL-y-8VLr5qr2E-WFxQl_zRYHvDrirwHMz";
  Response response = await dio.post('https://fcm.googleapis.com/fcm/send',
      data: notificationMap);
  log("Response : ${response.statusCode}");
  return response;
}
