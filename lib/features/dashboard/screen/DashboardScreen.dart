import 'package:animate_do/animate_do.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:fgi_y2j/features/dashboard/controller/dashboardController.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../config/helper/helperFunction.dart';
import '../../../config/route.dart';
import '../../../config/style/text_style.dart';
import '../../order/component/OrderHistoryHome.dart';
import '../../shopping_cart/screen/CartScreen.dart';
import '../../view_products/screen/AllProductHome.dart';
import '../../view_products/component/ProductFilterDrawer.dart';
import '../Component/dashDrawer.dart';
import '../Component/dashboardHome.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.put(DashBoardController());
    final allProductController = Get.put(AllProductController());
    final key = GlobalKey();

    return WillPopScope(
      onWillPop: () async {
        if (dashboardController.selectDrawerIndex.value == 0) {
          return onWillPop(context);
        } else {
          printLog("message");
          dashboardController.selectDrawerIndex.value--;
          Future.delayed(
            const Duration(milliseconds: 100),
            () {
              dashboardController.pageController.animateToPage(
                  dashboardController.selectDrawerIndex.value,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutExpo);
            },
          );
        }

        return false;
      },
      child: Scaffold(
        key: key,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: Colors.transparent,
          title: Obx(() {
            return Text(dashboardController.selectDrawerIndex.value == 0
                ? "DashBoard"
                : dashboardController.selectDrawerIndex.value == 1
                    ? "Order History"
                    : "Products");
          }),
          actions: [
            Obx(() {
              return dashboardController.selectDrawerIndex.value == 2
                  ? IconButton(
                      onPressed: () {
                        allProductController.isListAllProduct.value =
                            !allProductController.isListAllProduct.value;
                      },
                      icon: allProductController.isListAllProduct.value
                          ? const Icon(
                              CupertinoIcons.square_grid_2x2,
                              color: Colors.black,
                            )
                          : const Icon(
                              CupertinoIcons.list_bullet_below_rectangle))
                  : const Center();
            }),
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
          controller: dashboardController.pageController,
          onPageChanged: (value) {
            dashboardController.selectDrawerIndex.value = value;
          },
          physics: const NeverScrollableScrollPhysics(),
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
        floatingActionButton:
            Obx(() => dashboardController.homeScrollPosition.value == 0.0
                ? FadeInRight(
              duration: 300.ms,
                    child: FloatingActionButton.extended(
                        backgroundColor: const Color(0xFFF1C700),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onPressed: () {
                          // Get.put(AuthenticationController()).logout();
                          Get.to(const CartScreen(),
                              transition: Transition.upToDown);
                        },
                        label: Row(
                          children: [
                            const SizedBox(width: 5),
                            const Icon(FontAwesomeIcons.cartShopping),
                            const SizedBox(width: 10),
                            Text(
                              'Add new order',
                              style: AppTextStyles.drawerTextStyle.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 5),
                          ],
                        )),
                  )
                : Row(
              mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    FadeInLeft(
                      duration: 300.ms,
                        child: FloatingActionButton(
                            backgroundColor: const Color(0xFFF1C700),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onPressed: () {
                              // Get.put(AuthenticationController()).logout();
                              Get.to(const CartScreen(),
                                  transition: Transition.upToDown);
                            },
                            child:const Icon(FontAwesomeIcons.cartShopping)),
                      ),
                    SizedBox(width: 20,)
                  ],
                )),
      ),
    );
  }
}
