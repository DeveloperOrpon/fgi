import 'package:animate_do/animate_do.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:fgi_y2j/features/dashboard/controller/dashboardController.dart';
import 'package:fgi_y2j/features/order/controller/orderController.dart';
import 'package:fgi_y2j/features/shopping_cart/controller/cartController.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../Api/notification/NotificationController.dart';
import '../../../common_controller/AppController.dart';
import '../../../config/helper/helperFunction.dart';
import '../../../config/route.dart';
import '../../../config/style/text_style.dart';
import '../../../main.dart';
import '../../notification/controller/notificationController.dart';
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
    final theme=Theme.of(context);
    notificationPermission();
    final appController =Get.put(AppController());
    final dashboardController = Get.put(DashBoardController());
    final allProductController = Get.put(AllProductController());
    final cartController = Get.put(CartController());
    final dashBoardController = Get.put(DashBoardController());
    final notificationController=Get.put(AppNotificationController());
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
      child: Obx(() {
          return Scaffold(
            key: key,
            appBar:AppBar(
              leading:dashBoardController.selectDrawerIndex.value>0?  IconButton(onPressed: () {
                dashBoardController.selectDrawerIndex.value = 0;
                    dashBoardController.pageController.animateToPage(
                        dashBoardController.selectDrawerIndex.value,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutExpo);
              }, icon: Icon(Icons.arrow_back_ios)):null,
              bottom: PreferredSize(
                preferredSize:!appController.haveConnection.value? Size(Get.width,25):Size(0, 0),
                child:appController.haveConnection.value?const Center(): Container(
                  padding: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: const Text("No Internet",style: TextStyle(color: Colors.white,fontSize: 14),),
                ),
              ),
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                // For Android (dark icons)
                statusBarBrightness: Brightness.light, // For iOS (dark icons)
              ),
              backgroundColor: theme.scaffoldBackgroundColor,
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
                              ?  Icon(
                                  CupertinoIcons.square_grid_2x2,
                                  color: theme.shadowColor,
                                )
                              : const Icon(
                                  CupertinoIcons.list_bullet_below_rectangle))
                      : const Center();
                }),
                Stack(
                  children: [
                    IconButton(
                        onPressed: () {
                          AppRoute().notificationScreen();
                        },
                        icon:  Icon(
                          CupertinoIcons.bell,
                          color: theme.shadowColor,
                        )),
                    Obx(() {
                      return notificationController.countUnRead().isGreaterThan(0)
                          ? Positioned(
                        top: 0,
                        right: 5,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red,
                          child: Center(
                            child: Text(
                              "${notificationController.countUnRead()}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      )
                          : Center();
                    })
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                          onPressed: () {
                            AppRoute().cartPage();
                          },
                          icon:  Icon(
                            CupertinoIcons.shopping_cart,
                            color: theme.shadowColor,
                          )),
                    ),
                    Obx(() {
                      return cartController.cartItems.value.isNotEmpty
                          ? Positioned(
                              top: 0,
                              right: 5,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                child: Center(
                                  child: Text(
                                    "${cartController.cartItems.length}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            )
                          : Center();
                    })
                  ],
                )
              ],
            ),
            body: PageView(
              controller: dashboardController.pageController,
              onPageChanged: (value) {
                dashboardController.selectDrawerIndex.value = value;
              },
              // physics: const BouncingScrollPhysics(),
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                DashboardHome(),
                OrderHistoryHome(),
                // AllProductsHome(),
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
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            FloatingActionButton.extended(
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
                            Obx(() {
                              return cartController.cartItems.value.isNotEmpty
                                  ? Positioned(
                                      top: 0,
                                      right: 5,
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.red,
                                        child: Center(
                                          child: Text(
                                            "${cartController.cartItems.length}",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Center();
                            })
                          ],
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FadeInLeft(
                            duration: 300.ms,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                FloatingActionButton(
                                    backgroundColor: const Color(0xFFF1C700),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    onPressed: () {
                                      // Get.put(AuthenticationController()).logout();
                                      Get.to(const CartScreen(),
                                          transition: Transition.upToDown);
                                    },
                                    child:
                                        const Icon(FontAwesomeIcons.cartShopping)),
                                Obx(() {
                                  return cartController.cartItems.value.isNotEmpty
                                      ? Positioned(
                                          top: 0,
                                          right: 0,
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.red,
                                            child: Center(
                                              child: Text(
                                                "${cartController.cartItems.length}",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Center();
                                })
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      )),
          );
        }
      ),
    );
  }
}
