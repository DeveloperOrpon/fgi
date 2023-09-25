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
import '../component/OrderHistoryHome.dart';
import '../controller/orderController.dart';
import 'CompleteOrdersScreen.dart';
import 'InvoicesScreen.dart';
import 'PendingOrdersScreen.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
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
        body: const OrderHistoryHome(),
      ),
    );
  }
}
