import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/config/config.dart';
import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/shopping_cart/controller/BookingController.dart';
import 'package:fgi_y2j/features/shopping_cart/controller/cartController.dart';
import 'package:fgi_y2j/features/shopping_cart/model/CartRes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../config/style/text_style.dart';
import '../../dashboard/Component/dashboardHome.dart';
import '../../dashboard/screen/DashboardScreen.dart';

class CheckoutScreen extends StatelessWidget {
  final String pickTime;
  final String pickDate;

  const CheckoutScreen(
      {Key? key, required this.pickTime, required this.pickDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingController = Get.put(BookingController());
    final cartController = Get.put(CartController());
    cartController.getTotalProductPrice();
   Future.delayed(Duration(seconds: 1),() {
     if(cartController.cartItems
         .where((p) => p.isCheck)
         .toList().isEmpty){
       Get.offAll(DashboardScreen());
     }
   },);
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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
              child: Image.asset(
            "assets/images/leaves.png",
            color: Colors.grey.shade200,
          )),
          Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Stack(
                        alignment: Alignment.bottomRight,
                        clipBehavior: Clip.none,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 14),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Order Information",
                                            style: GoogleFonts.robotoMono(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          BounceInLeft(
                                            child: Container(
                                              height: 2,
                                              width: Get.width * .2,
                                              decoration: BoxDecoration(
                                                  color: Colors.amber),
                                            ),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          Get.back(result: "ScrollEdit");
                                        },
                                        label: const Text("Edit"),
                                        icon: const Icon(Icons.edit),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.grey.shade200),
                                      )
                                    ],
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 14),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Order Date",
                                        style: GoogleFonts.robotoMono(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        ": ${DateFormat('E, d MMM, y').format(DateTime.now())}",
                                        style: GoogleFonts.robotoMono(
                                            fontSize: 17,
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500),
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
                                        "Pickup Date",
                                        style: GoogleFonts.robotoMono(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        ": ${pickDate}",
                                        style: GoogleFonts.robotoMono(
                                            fontSize: 17,
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 14),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Pickup Time",
                                        style: GoogleFonts.robotoMono(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        ": ${pickTime}",
                                        style: GoogleFonts.robotoMono(
                                            fontSize: 17,
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 14),
                                child: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.location_solid,
                                      color: Colors.blue,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Order Address",
                                        style: GoogleFonts.robotoMono(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 14),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        "- ${cartController.addressController.text}${cartController.currentAddress.value}",
                                        style: GoogleFonts.robotoMono(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 14),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Additional Instructions",
                                            style: GoogleFonts.robotoMono(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    BounceInLeft(
                                      child: Container(
                                        height: 2,
                                        width: Get.width * .2,
                                        decoration:
                                            BoxDecoration(color: Colors.amber),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "-${cartController.additionalController.text.trim()}",
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.robotoMono(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Positioned(
                              bottom: -60,
                              right: -60,
                              child: Image.asset("assets/images/leaves.png"))
                        ],
                      )
                    ])),

                    //product
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ExpansionTile(
                          initiallyExpanded: true,
                          tilePadding: EdgeInsets.only(left: 6, right: 6),
                          collapsedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: Colors.grey.shade200, width: 1)),
                          title: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Order Items Information",
                                          style: GoogleFonts.robotoMono(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        BounceInLeft(
                                          child: Container(
                                            height: 2,
                                            width: Get.width * .2,
                                            decoration: BoxDecoration(
                                                color: Colors.amber),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          trailing: ElevatedButton.icon(
                            onPressed: null,
                            label: const Text("Details"),
                            icon: const Icon(Icons.arrow_drop_down_outlined),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.grey.shade200),
                          ),
                          children: [
                            ...cartController.cartItems
                                .where((p) => p.isCheck)
                                .toList()
                                .map((element) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 12),
                                      height: 80.0,
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(5),
                                                    child: CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        width: 90,
                                                        height: 70,
                                                        imageUrl: element
                                                                .productImage ??
                                                            "",
                                                        errorWidget:
                                                            (context, url,
                                                                    error) =>
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .primary,
                                                                        width:
                                                                            .5),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child: Text(
                                                                    appName,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade500,
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ),
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    downloadProgress) =>
                                                                const SpinKitFoldingCube(
                                                                  color: AppColors
                                                                      .primary,
                                                                  size: 20.0,
                                                                ))),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          element.productName ??
                                                              "",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .robotoMono(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                        Text(
                                                          "${element.price ?? ""}$currencySymbol x ${element.quantity ?? ""}",
                                                          style: GoogleFonts
                                                              .robotoMono(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          "Item Price: ${(element.price!) * (element.quantity!)} $currencySymbol",
                                                          style: GoogleFonts
                                                              .robotoMono(
                                                                  fontSize: 16,
                                                                  color:
                                                                      AppColors
                                                                          .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                        const Spacer(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 70,
                                            height: 35,
                                            padding: EdgeInsets.only(
                                                bottom: 6,
                                                top: 6,
                                                right: 4,
                                                left: 2),
                                            decoration: BoxDecoration(
                                                color: AppColors.red,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8))),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "${element.unitFlag == 1 ? "Piece" : "Box"}",
                                              style: GoogleFonts.robotoMono(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                              .animate(
                                                onPlay: (controller) =>
                                                    controller.repeat(
                                                        reverse: true),
                                              )
                                              .shake(
                                                  hz: 5,
                                                  duration:
                                                      Duration(seconds: 2),
                                                  delay: Duration(seconds: 2))
                                              .scaleXY(
                                                  duration:
                                                      Duration(seconds: 2),
                                                  delay: Duration(seconds: 2),
                                                  begin: 1,
                                                  end: 1.09)
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ],
                        ),
                      ),
                    ])),

                    ///pricing
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 14),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order Summary",
                                    style: GoogleFonts.robotoMono(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              BounceInLeft(
                                child: Container(
                                  height: 2,
                                  width: Get.width * .2,
                                  decoration:
                                      BoxDecoration(color: Colors.amber),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 14),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Text(
                                "Total Products Count :",
                                style: GoogleFonts.robotoMono(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Obx(() {
                                return Text(
                                  "${itemsCount(cartController)}",
                                  style: GoogleFonts.robotoMono(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 0.0, horizontal: 14),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         flex: 3,
                      //         child: Text(
                      //           "Subtotal",
                      //           style: AppTextStyles.drawerTextStyle.copyWith(
                      //               fontSize: 18,
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.w400),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 5,
                      //         child: Obx(() {
                      //           return Text(
                      //             "= ${cartController.totalProductPrice.value} $currencySymbol",
                      //             style: AppTextStyles.drawerTextStyle.copyWith(
                      //                 fontSize: 17,
                      //                 color: Colors.black,
                      //                 fontWeight: FontWeight.w400),
                      //           );
                      //         }),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 0.0, horizontal: 14),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         flex: 3,
                      //         child: Text(
                      //           "Other + Tex",
                      //           style: AppTextStyles.drawerTextStyle.copyWith(
                      //               fontSize: 18,
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.w400),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 5,
                      //         child: Text(
                      //           "= -",
                      //           style: AppTextStyles.drawerTextStyle.copyWith(
                      //               fontSize: 17,
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.w400),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 14),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Items Total",
                                style: GoogleFonts.robotoMono(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                "= ${cartController.totalProductPrice.value} $currencySymbol",
                                style: GoogleFonts.robotoMono(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 14),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Total Payable",
                                style: GoogleFonts.robotoMono(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                "= ${cartController.totalProductPrice.value} $currencySymbol",
                                style: GoogleFonts.robotoMono(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])),

                    ///product Information
                  ],
                ),
              ),
              const SizedBox(height: 10),
              BounceInUp(
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Total = ${cartController.totalProductPrice.value} $currencySymbol",
                          style: GoogleFonts.robotoMono(
                              fontSize: 17,
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "(All Cost Included Here..)",
                          style: GoogleFonts.robotoMono(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )),
                    Padding(
                      padding: const EdgeInsets.only(right: 13.0),
                      child: ElevatedButton(
                        onPressed: () {
                          startLoading("Please Wait");
                          cartController
                              .placeAOrder(context, "$pickTime,$pickDate")
                              .then((value) {
                            if (!value) {
                              bookingController
                                  .showBookingFailedDialog(context);
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Place Order",
                            style: GoogleFonts.robotoMono(
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}

String itemsCount(CartController cartController) {
  String count = '';
  num piece = 0;
  num box = 0;
  num other = 0;
  for (CartModel cartModel in cartController.cartItems) {
    if(cartModel.unitFlag == 1){
      piece+=cartModel.quantity??0;
    }
    else if(cartModel.unitFlag == 0)
      {
        box+=cartModel.quantity??0;
      }else{
      other+=cartModel.quantity??0;
    }
  }
  if (piece > 0) {
    count += '$piece ${piece.isGreaterThan(1) ? "Pieces" : "Piece"}';
  }
  if (box > 0) {
    count += ' $box ${box.isGreaterThan(1) ? "Boxes" : "Box"}';
  }
  if (other > 0) {
    count += ' $other ${other.isGreaterThan(1) ? "Others" : "Other"}';
  }
  return count;
}
