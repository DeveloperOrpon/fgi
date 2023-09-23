import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../config/style/text_style.dart';
import '../Component/dashDrawer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("DashBoard"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.bell,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.shopping_cart,
                color: Colors.black,
              ))
        ],
      ),
      drawer: DashDrawer(),
      backgroundColor: CupertinoColors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
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
    );
  }
}
