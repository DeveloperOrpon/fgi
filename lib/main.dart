import 'package:fgi_y2j/config/theme/themes.dart';
import 'package:fgi_y2j/features/dashboard/screen/DashboardScreen.dart';
import 'package:fgi_y2j/redirectScreeen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'config/helper/helperFunction.dart';

Future<void> main() async {
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
      title: 'Flutter Demo',
      theme:AppThemes.main(),
      home: const RedirectScreen(),
    );
  }
}
