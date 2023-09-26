import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../config/config.dart';


authenticationErrorDialog(String title, String message) {
  EasyLoading.dismiss();
  Get.snackbar(
    title,
    message,
    backgroundColor: Colors.red,
    duration: SNACKBAR_DURATION,
    snackPosition: SNACKBAR_POSITION,
    icon: const Icon(Icons.info_outline_rounded),
    colorText: Colors.white,
    barBlur: 2.0,
    isDismissible: true,
    snackStyle: SnackStyle.FLOATING,

  );
}
  authenticationLogSuccessDialog(String title, String message) {
    EasyLoading.dismiss();
  Get.snackbar(
    title,
    message,
    backgroundColor: Colors.green,
    duration: SNACKBAR_DURATION,
    snackPosition: SNACKBAR_POSITION,
    icon: const Icon(Icons.info_outline_rounded),
    colorText: Colors.white,
    barBlur: 2.0,
    isDismissible: true,
    snackStyle: SnackStyle.FLOATING,

  );
}
