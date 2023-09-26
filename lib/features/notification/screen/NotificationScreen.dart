import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/common_component/simpleAppBar.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

import '../component/NotificationContent.dart';
import '../component/TransactionContent.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarComponent(title: "Notification", onTap: (){}),
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
