import 'dart:developer';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/view_products/component/AllProductHome.dart';
import 'package:fgi_y2j/features/view_products/component/single_product_ui.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/helper/helperFunction.dart';
import '../../../config/route.dart';
import '../../../config/style/text_style.dart';
import '../../dashboard/Component/dashDrawer.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () => onWillPop(context),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            backgroundColor: Colors.transparent,
            title: const Text("Products"),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.bell,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {
                    AppRoute().cartPage();
                  },
                  icon: const Icon(
                    CupertinoIcons.shopping_cart,
                    color: Colors.black,
                  ))
            ],
          ),
          drawer: const DashDrawer(),
          body: const AllProductsHome(),
        ));

  }

}
