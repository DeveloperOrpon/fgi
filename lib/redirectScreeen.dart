import 'dart:convert';
import 'dart:developer';

import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:fgi_y2j/features/authentication/model/UserRes.dart';
import 'package:fgi_y2j/features/authentication/screen/SignUpScreen.dart';
import 'package:fgi_y2j/features/cache_stroage/localStroage.dart';
import 'package:fgi_y2j/features/dashboard/screen/DashboardScreen.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/authentication/screen/loginScreen.dart';
import 'features/dashboard/controller/dashboardController.dart';

class RedirectScreen extends StatelessWidget {
  const RedirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController=Get.put(AuthenticationController());
   Get.put(DashBoardController());
    Get.put(AllProductController());
    Get.put(AllProductController());

    Future.delayed(const Duration(seconds: 0),() async {

      String? jwt=await LocalStorage.getJWT();
      if(jwt==null || jwt.isEmpty) {
        Get.offAll(const LoginScreen(),transition: Transition.cupertino,binding:BindingsBuilder(()=> AuthenticationController()));
      }else{
        // authController.logout();
        String? userMapString=await LocalStorage.getUserInformation();
        Map<String, dynamic> userMap =json.decode(userMapString!);
        printLog("userMapString ${userMapString.runtimeType}");
        UserModel userModel=UserModel.fromJson(userMap);
        authController.userModel.value=userModel;
        Get.offAll(const DashboardScreen(),transition: Transition.cupertino,);
      }
    },);
    final key=GlobalKey();
    return Scaffold(
      key:key,
      body: const Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
