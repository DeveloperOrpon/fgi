import 'package:animate_do/animate_do.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../../../config/helper/helperFunction.dart';
import '../../../config/route.dart';
import '../../../config/style/text_style.dart';
import '../../dashboard/Component/dashDrawer.dart';
import '../../notification/controller/notificationController.dart';
import '../../shopping_cart/controller/cartController.dart';
import '../component/OrderHistoryHome.dart';
import '../controller/orderController.dart';
import 'CompleteOrdersScreen.dart';
import '../../invoice/screen/InvoicesScreen.dart';
import 'PendingOrdersScreen.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    final cartController = Get.put(CartController());
    final notificationController=Get.put(AppNotificationController());
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BounceInUp(
          child: FloatingActionButton.extended(
              backgroundColor: Color(0xFFF1C700),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onPressed: () {},
              label: Row(
                children: [
                  const SizedBox(width: 5),
                  const Icon(FontAwesomeIcons.cartShopping),
                  const SizedBox(width: 10),
                  Text(
                    'Add new order',
                    style: AppTextStyles.drawerTextStyle.copyWith(
                        fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                  const SizedBox(width: 5),
                ],
              )),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: Colors.transparent,
          title: const Text("Order History"),
          actions: [
            Stack(
              children: [
                IconButton(
                    onPressed: () {
                      AppRoute().notificationScreen();
                    },
                    icon: const Icon(
                      CupertinoIcons.bell,
                      color: Colors.black,
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
                      icon: const Icon(
                        CupertinoIcons.shopping_cart,
                        color: Colors.black,
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
        drawer: const DashDrawer(),
        body: const OrderHistoryHome(),
      ),
    );
  }
}
