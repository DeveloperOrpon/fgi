import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fgi_y2j/Api/firebase_notification_service.dart';
import 'package:fgi_y2j/Notification/LocalNotification.dart' as ND;
import 'package:firebase_core/firebase_core.dart';
import 'package:fgi_y2j/config/theme/themes.dart';
import 'package:fgi_y2j/features/dashboard/screen/DashboardScreen.dart';
import 'package:fgi_y2j/redirectScreeen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'Api/notification/NotificationController.dart';
import 'Api/notification/fcm.dart';
import 'Api/notification/notification_service.dart';
import 'config/config.dart';
import 'config/helper/helperFunction.dart';
import 'features/custom_error/CustomError.dart';
import 'features/dashboard/Component/dashboardHome.dart';
import 'features/notification/screen/NotificationScreen.dart';
import 'firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  printLog('Handling a background message ${message.messageId}');
  printLog('Handling a background message ${message.data}');
  // createNotification(message);
}
handleMessage(RemoteMessage value){

  Get.offAll(DashboardHome());
  Get.to(NotificationScreen());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());

  configFcm();
  initLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeMode,
        builder: (context, theme, child) {
          return GetMaterialApp(
            darkTheme: AppThemes.main(),
            themeMode: theme,
            theme: AppThemes.main(),
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            title: appName,
            home: const RedirectScreen(),
          );
        });
  }
}

notificationPermission() async {
  PermissionStatus status = await Permission.notification.status;
  if (!status.isGranted) {
    await Permission.notification.request();
  }
}
