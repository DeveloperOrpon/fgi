import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/var_const.dart';
import '../../view_products/Model/ProductRes.dart';

SizedBox buildOutlineMinButton({required Function press}) {
  return SizedBox(
    height: 38,
    width: 45,
    child: ElevatedButton(
        style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ))),
        onPressed: () {
          press();
        },
        child: const Icon(CupertinoIcons.minus)),
  );
}
SizedBox buildOutlineDisButton({required Function press}) {
  return SizedBox(
      height: 38,
      width: 45,
      child: ElevatedButton(
        style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ))),

        onPressed: () {
          press();
        },
        child: const Icon(CupertinoIcons.plus),
      ));
}
