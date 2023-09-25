import 'package:animate_do/animate_do.dart';
import 'package:fgi_y2j/config/config.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/shopping_cart/controller/BookingController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../config/style/text_style.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingController=Get.put(BookingController());
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
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 14),
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
                            onPressed: () {
                              Get.back(result: "ScrollEdit");
                            },
                            label: const Text("Edit"),
                            icon: const Icon(Icons.edit),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade200),
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 14),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Order Date",
                            style: AppTextStyles.drawerTextStyle.copyWith(
                                fontSize: 16,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 14),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Pickup Date",
                            style: AppTextStyles.drawerTextStyle.copyWith(
                                fontSize: 16,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 14),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Additional Instructions",
                            style: AppTextStyles.drawerTextStyle.copyWith(
                                fontSize: 16,
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
                ///pricing
                SliverList(delegate: SliverChildListDelegate([
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pricing Information",
                            style: AppTextStyles.drawerTextStyle.copyWith(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 14),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            "Total Products Count ",
                            style: AppTextStyles.drawerTextStyle.copyWith(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            ": 20 Items",
                            style: AppTextStyles.drawerTextStyle.copyWith(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ), Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 14),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Subtotal",
                            style: AppTextStyles.drawerTextStyle.copyWith(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            "= 2000 $currencySymbol",
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 14),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Other + Tex",
                            style: AppTextStyles.drawerTextStyle.copyWith(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            "= 100 $currencySymbol",
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 14),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Grand Total",
                            style: AppTextStyles.drawerTextStyle.copyWith(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            "= 2100 $currencySymbol",
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 14),
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
                            onPressed: () {
                              Get.back();
                            },
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
                        (context, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 6.0, horizontal: 12),
                              height: 100.0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade200,
                                        offset: Offset(3, 3),
                                        spreadRadius: 3,
                                        blurRadius: 3,
                                      )
                                    ]),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/demo/demo2.png",
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.contain,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Double Patty Burger",
                                              style: AppTextStyles
                                                  .drawerTextStyle
                                                  .copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                            Text(
                                              "222 $currencySymbol",
                                              style: AppTextStyles
                                                  .drawerTextStyle
                                                  .copyWith(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "Total: $currencySymbol 200 (30pcs)",
                                              style: AppTextStyles
                                                  .drawerTextStyle
                                                  .copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        childCount: 5)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          BounceInUp(
            child: Center(
              child: CupertinoButton(
                onPressed: () {
                  bookingController.showBookingConfirmDialog(context);
                },
                color: AppColors.primary,
                child: const Text("Checkout"),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
