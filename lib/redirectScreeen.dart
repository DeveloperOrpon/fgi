import 'package:fgi_y2j/features/authentication/screen/SIgnUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/authentication/screen/loginScreen.dart';

class RedirectScreen extends StatelessWidget {
  const RedirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1),() {
      Get.to(const SignUpScreen(),transition: Transition.cupertino);
    },);
    return Scaffold(
      body: Center(
        child: Text('RedirectScreen') ,
      ),
    );
  }
}
