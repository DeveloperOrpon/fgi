import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fgi_y2j/config/theme/themes.dart';
import 'package:fgi_y2j/features/dashboard/screen/DashboardScreen.dart';
import 'package:fgi_y2j/redirectScreeen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'config/config.dart';
import 'config/helper/helperFunction.dart';
import 'features/custom_error/CustomError.dart';

Future<void> main() async {
  ErrorWidget.builder=(details) => errorWidget();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  initLoading();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: appName,
      theme:AppThemes.main(),
      home:  RedirectScreen(),
    );
  }
}
