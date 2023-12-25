import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart' as TOAST;
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../../config/config.dart';

authenticationErrorDialog(String title, String message) {
  EasyLoading.dismiss();
  Get.snackbar(title, message,
      backgroundColor: Colors.red.shade200,
      duration: SNACKBAR_DURATION,
      snackPosition: SNACKBAR_POSITION,
      dismissDirection: DismissDirection.vertical,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 15.5,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            ),
            height: Get.height * .1,
          ),
          const SizedBox(
            width: 2.5,
          ),
          const Icon(
            Icons.info_outline_rounded,
            color: Colors.white,
          )
        ],
      ),
      colorText: Colors.white,
      barBlur: 2.0,
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      borderRadius: 5);
}

showErrorDialog(String title, String message, BuildContext context) {
  EasyLoading.dismiss();
  MotionToast.error(
    position: MotionToastPosition.bottom,
    animationCurve: Curves.fastLinearToSlowEaseIn,
    animationDuration: const Duration(seconds: 1),
    layoutOrientation: ToastOrientation.ltr,
    toastDuration: const Duration(seconds: 4),
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    description: Text(message, style: const TextStyle(fontSize: 12)),
    animationType: AnimationType.fromRight,
  ).show(context);
}

showErrorDialogInTop(String title, String message, BuildContext context) {
  EasyLoading.dismiss();
  MotionToast.error(
    height: 75,
    width: Get.width * .9,
    position: MotionToastPosition.top,
    animationCurve: Curves.fastLinearToSlowEaseIn,
    animationDuration: const Duration(seconds: 1),
    layoutOrientation: ToastOrientation.ltr,
    toastDuration: const Duration(seconds: 4),
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    description: Text(message, style: const TextStyle(fontSize: 12)),
    animationType: AnimationType.fromRight,
  ).show(context);
}

showSuccessDialogInTop(String title, String message, BuildContext context) {
  EasyLoading.dismiss();
  CherryToast.success(
      animationCurve: Curves.fastOutSlowIn,

      borderRadius: 10,
      width: Get.width,
      shadowColor: Colors.green.shade100,
      backgroundColor: Colors.green.shade100,
      animationDuration: const Duration(milliseconds: 400),
      toastDuration:const Duration(seconds: 2) ,
      toastPosition:TOAST.Position.top ,
      animationType: TOAST.AnimationType.fromTop,
      description: Text(message,style: const TextStyle(color: Colors.black)),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
        maxLines: 2,
      )).show(context);
}

showSuccessToastTop(String title, String message, BuildContext context) {
  EasyLoading.dismiss();
  CherryToast.success(
    animationCurve: Curves.fastOutSlowIn,

    borderRadius: 10,
    width: Get.width,
    shadowColor: Colors.green.shade100,
    backgroundColor: Colors.green.shade100,
    animationDuration: const Duration(milliseconds: 400),
    toastDuration:const Duration(seconds: 2) ,
    toastPosition:TOAST.Position.top ,
    animationType: TOAST.AnimationType.fromTop,
    description: Text(message,style: const TextStyle(color: Colors.black)),
      title: Text(
        title,
    style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
    maxLines: 2,
  )).show(context);
}
showInformationToastTop(String title, String message, BuildContext context) {
  EasyLoading.dismiss();
  CherryToast.warning(
    animationCurve: Curves.fastOutSlowIn,

    borderRadius: 10,
    width: Get.width,
    shadowColor: Colors.amber.shade100,
    backgroundColor: Colors.amber.shade100,
    animationDuration: const Duration(milliseconds: 400),
    toastDuration:const Duration(seconds: 2) ,
    toastPosition:TOAST.Position.top ,
    animationType: TOAST.AnimationType.fromTop,
    description: Text(message,style: const TextStyle(color: Colors.black)),
      title: Text(
        title,
    style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
    maxLines: 2,
  )).show(context);
}

showSuccessDialog(String title, String message, BuildContext context) {
  EasyLoading.dismiss();
  MotionToast.success(
    height: 90,
    width: Get.width * .9,
    position: MotionToastPosition.bottom,
    animationCurve: Curves.fastLinearToSlowEaseIn,
    animationDuration: const Duration(seconds: 1),
    layoutOrientation: ToastOrientation.ltr,
    toastDuration: const Duration(seconds: 2),
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    description: Text(message, style: const TextStyle(fontSize: 12)),
    animationType: AnimationType.fromRight,
    dismissable: true,

  ).show(context);
}

authenticationLogSuccessDialog(String title, String message) {
  EasyLoading.dismiss();
  Get.snackbar(title, message,
      backgroundColor: Colors.green.shade200,
      duration: SNACKBAR_DURATION,
      snackPosition: SNACKBAR_POSITION,
      dismissDirection: DismissDirection.vertical,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 15.5,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5),
            ),
            height: Get.height * .1,
          ),
          const SizedBox(
            width: 2.5,
          ),
          const Icon(
            Icons.info_outline_rounded,
            color: Colors.white,
          )
        ],
      ),
      colorText: Colors.white,
      barBlur: 2.0,
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      borderRadius: 5);
}
