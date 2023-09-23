import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../config/helper/helperFunction.dart';
import '../../../config/style/text_style.dart';
import '../Component/dashDrawer.dart';
import '../Component/dashboardHome.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle:const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.white,
          ) ,
          backgroundColor: Colors.transparent,
          title: const Text("DashBoard"),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.bell,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.shopping_cart,
                  color: Colors.black,
                ))
          ],
        ),
        body: const DashboardHome(),
        drawer: const DashDrawer(),
        backgroundColor: CupertinoColors.white,
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
                  SizedBox(width: 5),
                  Icon(FontAwesomeIcons.cartShopping),
                  SizedBox(width: 10),
                  Text(
                    'Add new order',
                    style: AppTextStyles.drawerTextStyle
                        .copyWith(fontWeight: FontWeight.w400,color: Colors.black),
                  ),SizedBox(width: 5),

                ],
              )),
        ),
      ),
    );
  }
}
