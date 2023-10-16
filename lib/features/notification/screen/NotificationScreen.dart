import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/common_component/simpleAppBar.dart';
import 'package:fgi_y2j/features/dashboard/Component/dashboardHome.dart';
import 'package:fgi_y2j/features/shopping_cart/screen/CartScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../component/NotificationContent.dart';
import '../component/TransactionContent.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        title: Text('Notification'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.bell_solid,
                color: AppColors.primary,
              )),
          IconButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Get.to(const CartScreen(),transition: Transition.upToDown);
              },
              icon: const Icon(
                CupertinoIcons.shopping_cart,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 0.4)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: ContainedTabBarView(
              tabs: const [
                Text(
                  'Notification',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Transactions',
                  style: TextStyle(fontSize: 16),
                ),
              ],
              tabBarProperties: TabBarProperties(
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.grey[400],
              ),
              views: const [NotificationContent(), TransactionContent()],
              onChange: (index) => print(index),
            ),
          ),
        ),
      ),
    );
  }
}
