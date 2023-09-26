import 'package:animate_do/animate_do.dart';
import 'package:fgi_y2j/features/dashboard/controller/dashboardController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../config/helper/helperFunction.dart';
import '../../../config/route.dart';
import '../../../config/style/text_style.dart';
import '../../order/component/OrderHistoryHome.dart';
import '../../view_products/component/AllProductHome.dart';
import '../../view_products/component/ProductFilterDrawer.dart';
import '../Component/dashDrawer.dart';
import '../Component/dashboardHome.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardController=Get.put(DashBoardController());
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: Colors.transparent,
          title:  Obx(() {
            return Text(dashboardController.selectDrawerIndex.value == 0
                ? "DashBoard"
                : dashboardController.selectDrawerIndex.value == 1
                    ? "Order History"
                    : "Products");
          }
          ),
          actions: [
            IconButton(
                onPressed: () {
                  AppRoute().notificationScreen();
                },
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
        body: PageView(
          controller:dashboardController.pageController ,
          onPageChanged: (value) {
            dashboardController.selectDrawerIndex.value=value;
          },
          physics: const BouncingScrollPhysics(),
          children: const [
            DashboardHome(),
            OrderHistoryHome(),
            AllProductsHome(),
          ],
        ),
        drawer: const DashDrawer(),
        endDrawer: const ProductFilterDrawer(),
        backgroundColor: CupertinoColors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BounceInUp(
            child: FloatingActionButton.extended(
            backgroundColor: const Color(0xFFF1C700),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onPressed: () {
                onlyLoading();
              printLog("message");
              },
              label: Row(
                children: [
                  const SizedBox(width: 5),
                  const Icon(FontAwesomeIcons.cartShopping),
                  const SizedBox(width: 10),
                  Text(
                    'Add new order',
                    style: AppTextStyles.drawerTextStyle
                        .copyWith(fontWeight: FontWeight.w400,color: Colors.black),
                  ),const SizedBox(width: 5),

                ],
              )),
        ),
      ),
    );
  }
}
