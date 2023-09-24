import 'package:fgi_y2j/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/style/text_style.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

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
        title: const Text("Checkout"),
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
                Icons.shopping_cart_sharp,
                color: Colors.amber,
              ))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your Information",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: const Text("Edit"),
                      icon: const Icon(Icons.edit),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200),
                    )
                  ],
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Order Date",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      "15 August, 2024",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Pickup Date",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      "28 August, 2024",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Additional Instructions",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      "-",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ])),

          ///product Information
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Products",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: const Text("Edit"),
                      icon: const Icon(Icons.edit),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200),
                    )
                  ],
                )),
          ])),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => SizedBox(
                    height: 120.0,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Card(
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/demo/demo2.png",
                              width: 120,
                              height: 120,
                              fit: BoxFit.fitHeight,
                            ),
                             Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text("Double Patty Burger",style: AppTextStyles.drawerTextStyle.copyWith(
                                       fontSize: 16,
                                       color: Colors.black,
                                       fontWeight: FontWeight.w400),),
                                    Text("222 $currencySymbol",style: AppTextStyles.drawerTextStyle.copyWith(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),),
                                  const Spacer(),
                                  Text("Total: $currencySymbol 200 (30pcs)",style: AppTextStyles.drawerTextStyle.copyWith(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  childCount: 5))
        ],
      ),
    );
  }
}
