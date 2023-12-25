import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/features/dashboard/Component/dashboardHome.dart';
import 'package:fgi_y2j/features/dashboard/screen/DashboardScreen.dart';
import 'package:fgi_y2j/features/shopping_cart/controller/cartController.dart';
import 'package:fgi_y2j/features/shopping_cart/screen/checkoutScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config.dart';
import '../../../config/style/app_colors.dart';
import '../model/OrderRes.dart';

class OrderConfirmScreen extends StatelessWidget {
  final OrderResModel orderResModel;

  const OrderConfirmScreen({super.key, required this.orderResModel});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(DashboardScreen(), transition: Transition.fadeIn);
        return false;
      },
      child: Scaffold(
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
                Get.offAll(DashboardScreen(), transition: Transition.fadeIn);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: Text("Order Confirmation"),
        ),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                height: 60,
                padding: EdgeInsets.only(left: 8, right: 8),
                width: Get.width,
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "It's Ordered!",
                      style: GoogleFonts.roboto(color: Colors.black54),
                    ),
                    Text("Order No #${orderResModel.sId!.substring(0, 6)}",
                        style: GoogleFonts.robotoMono(
                            color: Colors.black54, fontSize: 14)),
                  ],
                ),
              )
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: ExpansionTile(
                  collapsedBackgroundColor: Colors.grey.shade200,
                  initiallyExpanded: true,
                  textColor: Colors.black54,
                  collapsedShape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(
                    "ORDER DETAILS",
                    style: GoogleFonts.robotoMono(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  children: [
                    ...orderResModel.items!
                        .map((item) => Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 10, bottom: 5),
                              height: 95,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: .5,
                                    )),
                                margin: EdgeInsets.zero,
                                elevation: 0,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 85,
                                      width: 90,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          width: 70,
                                          fit: BoxFit.fill,
                                          imageUrl: item.productImage ?? "",
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors.primary,
                                                    width: .5)),
                                            child: Center(
                                              child: Text(
                                                "$appName",
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade200),
                                              ),
                                            ),
                                          ),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              const SpinKitFoldingCube(
                                            color: AppColors.primary,
                                            size: 20.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            "${item.productName ?? ""}",
                                            style: GoogleFonts.robotoMono(
                                                fontSize: 13),
                                          ),
                                          Text(
                                            "${item.productPrice ?? 0 * item.productQuantity!} $currencySymbol",
                                            style: GoogleFonts.robotoMono(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      left: 8, right: 8),
                                                  height: 35,
                                                  // width: 55,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                        color: Colors
                                                            .grey.shade400,
                                                        width: .5,
                                                      )),
                                                  child: Text(
                                                    "${item.productQuantity ?? ""} ${item.productUnitType}",
                                                    style:
                                                        GoogleFonts.robotoMono(
                                                      fontSize: 14,
                                                    ),
                                                  )),
                                              Expanded(
                                                child: Center(),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 8),
                      child: Center(
                        child: Dash(
                            direction: Axis.horizontal,
                            length: Get.width - 20,
                            dashLength: 8,
                            dashGap: 3,
                            dashColor: AppColors.primary,
                            dashBorderRadius: 0,
                            dashThickness: 1),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            textAlign: TextAlign.start,
                            "Delivery Date ",
                            style: GoogleFonts.robotoMono(fontSize: 14),
                          ),
                        ),
                        Text(":"),
                        Expanded(
                          flex: 3,
                          child: Text(
                            textAlign: TextAlign.right,
                            "${orderResModel.pickupTime}",
                            style: GoogleFonts.robotoMono(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Items Count ",
                              style: GoogleFonts.robotoMono(fontSize: 14),
                            ),
                          ),
                          Text(":"),
                          Expanded(
                            flex: 3,
                            child: Text(
                              textAlign: TextAlign.right,
                              "${orderResModel.items!.length} Items",
                              style: GoogleFonts.robotoMono(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Total Payable ",
                            style: GoogleFonts.robotoMono(fontSize: 14),
                          ),
                        ),
                        Text(":"),
                        Expanded(
                          flex: 3,
                          child: Text(
                            textAlign: TextAlign.right,
                            "${orderResModel.totalCost} $currencySymbol",
                            style: GoogleFonts.robotoMono(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.red,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ])),
            //message
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 8),
                child: Center(
                  child: Dash(
                      direction: Axis.horizontal,
                      length: Get.width / 2 - 20,
                      dashLength: 8,
                      dashGap: 3,
                      dashColor: AppColors.primary,
                      dashBorderRadius: 0,
                      dashThickness: 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 16, right: 12),
                child: Text(
                  textAlign: TextAlign.center,
                  "You've successfully placed the order",
                  style: GoogleFonts.robotoMono(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                    textAlign: TextAlign.justify,
                    "You can check status of your order by using our delivery status feature. You will receive order confirmation e-mail with order details and order INVOICE. \n\nThanks For Ordered",
                    style: GoogleFonts.robotoSerif(
                      fontSize: 14,
                      color: Colors.black87,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoButton.filled(
                  child: Text(
                    "Back To Home",
                    style: GoogleFonts.robotoSerif(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Get.offAll(DashboardScreen(),
                        transition: Transition.fadeIn);
                  },
                ),
              )
            ]))
          ],
        ),
      ),
    );
  }
}

