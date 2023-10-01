import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../config/route.dart';

appBarComponent({required String title,required Function onTap}) {
  return AppBar(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ),
    backgroundColor: Colors.transparent,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const Icon(Icons.arrow_back_ios_new),
    ),
    title: Text(title),
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.bell,
            color: Colors.black,
          )),
      IconButton(
          onPressed: () {
            onTap();
          },
          icon: const Icon(
            CupertinoIcons.shopping_cart,
            color: Colors.black,
          ))
    ],
  );
}
