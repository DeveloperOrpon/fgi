import 'package:fgi_y2j/config/theme/themes.dart';
import 'package:fgi_y2j/features/dashboard/screen/DashboardScreen.dart';
import 'package:fgi_y2j/redirectScreeen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme:AppThemes.main(),
      home: const DashboardScreen(),
    );
  }
}
