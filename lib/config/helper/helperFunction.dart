import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../style/app_colors.dart';

Future<bool> onWillPop(BuildContext context) async {
  bool? exitResult = await showDialog(
    context: context,
    builder: (context) => _buildExitDialog(context),
  );
  return exitResult ?? false;
}

BackdropFilter _buildExitDialog(BuildContext context) {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
    child: AlertDialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      content: Container(
        width: Get.width,
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Lottie.asset(
                  'assets/animation/exit_animation.json',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,

                ),
              ),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Do you want to exit the app?',
                      style: TextStyle(color: Colors.red,fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:  <Widget>[

                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    child: const Text(
                      'Yes',
                      style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'No',
                      style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

printLog(String message){
  log(message,time: DateTime.now(),name: "!!--DeveloperOrpon!!--",zone:Zone.current );
}

startLoading(String title) {
  EasyLoading.show(
    status: title,
    indicator: const CupertinoActivityIndicator(radius: 22),
  );
}
onlyLoading() {
  EasyLoading.show(
    indicator: const Padding(
      padding: EdgeInsets.all(8.0),
      child: CupertinoActivityIndicator(radius: 22),
    ),
  );
}

initLoading(){
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.pulse
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 100.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.red
    ..textColor = Colors.black
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true;
}