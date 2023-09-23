
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../config/style/text_style.dart';

class CompleteOrderScreen extends StatelessWidget {
  const CompleteOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.white,
        ),
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: const Icon(Icons.arrow_back_ios_new)),
        backgroundColor: Colors.transparent,
        title: const Text("Completed Orders"),
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
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      hintText: "Search",
                      hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 16),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                  ),
                )
              ])),
          ///Pending Order History
          ///Completed Order History
          SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 15),
                Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Completed Orders",
                          style: AppTextStyles.drawerTextStyle.copyWith(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),
              ])),
          SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "August, 2023",
                    style: AppTextStyles.drawerTextStyle.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),

                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.green,
                      ),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                                'Triifol Burgers: 56psc buns, 20psc Mustard, 100 Coca-cola cans, 40pcs Tyson Chicken'),
                          ))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.green,
                      ),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text('Riley’s Kitchen: 6psc buns, 2psc Mustard'),
                          ))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.green,
                      ),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                                'Triifol Burgers: 56psc buns, 20psc Mustard, 100 Coca-cola cans, 40pcs Tyson Chicken'),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "September, 2023",
                    style: AppTextStyles.drawerTextStyle.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.green,
                      ),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                                'Triifol Burgers: 56psc buns, 20psc Mustard, 100 Coca-cola cans, 40pcs Tyson Chicken'),
                          ))
                    ],
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
