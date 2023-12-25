import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../../config/config.dart';
import '../../../config/route.dart';
import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../invoice/screen/InvoiceScreenPreview.dart';
import '../../notification/controller/notificationController.dart';
import '../../shopping_cart/controller/cartController.dart';
import '../../shopping_cart/model/OrderRes.dart';
import '../controller/orderController.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderResModel orderResModel;

  const OrderDetailsScreen({super.key, required this.orderResModel});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    final notificationController = Get.put(AppNotificationController());
    final orderController = Get.put(OrderController());
    if (orderController.acceptOrderResponse.value == null) {
      orderController.acceptOrderInformation(1);
    }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(InvoiceScreenPreview(orderResModel: orderResModel),
                transition: Transition.fadeIn);
          },
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.printer_fill),
              SizedBox(
                width: 8,
              ),
              Text('Invoice')
            ],
          )),
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
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text(
          "Order Id #${orderResModel.sId}",
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    AppRoute().notificationScreen();
                  },
                  icon: const Icon(
                    CupertinoIcons.bell,
                    color: Colors.black,
                  )),
              Obx(() {
                return notificationController.countUnRead().isGreaterThan(0)
                    ? Positioned(
                        top: 0,
                        right: 5,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red,
                          child: Center(
                            child: Text(
                              "${notificationController.countUnRead()}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      )
                    : Center();
              })
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                    onPressed: () {
                      AppRoute().cartPage();
                    },
                    icon: const Icon(
                      CupertinoIcons.shopping_cart,
                      color: Colors.black,
                    )),
              ),
              Obx(() {
                return cartController.cartItems.value.isNotEmpty
                    ? Positioned(
                        top: 0,
                        right: 5,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red,
                          child: Center(
                            child: Text(
                              "${cartController.cartItems.length}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      )
                    : Center();
              })
            ],
          )
        ],
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: orderResModel.items!.length, (context, index) {
            var order = orderResModel.items![index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: "${orderResModel.items![0].sId}",
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              height: 80,
                              fit: BoxFit.cover,
                              width: Get.width * .2,
                              imageUrl: order.productImage ?? "",
                              errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColors.primary, width: .5)),
                                child: Center(
                                  child: Text(
                                    "$appName",
                                    style:
                                        TextStyle(color: Colors.grey.shade200),
                                  ),
                                ),
                              ),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      const SpinKitFoldingCube(
                                color: AppColors.primary,
                                size: 50.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 4, top: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                "${order.productName}",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                "Price : ${order.productPrice}",
                                style: GoogleFonts.robotoMono(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Text(
                                  "Qty: ${order.productQuantity} (${order.productUnitType}-${order.product_unit_value})",
                                  style: GoogleFonts.robotoMono(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: AppColors.red)),
                            ],
                          ),
                        ))
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Item Price"),
                            Text(
                                "${order.productPrice! * order.productQuantity!}$currencySymbol",
                                style: GoogleFonts.robotoMono(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )),
                    ],
                  ),
                )
              ],
            );
          })),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                "Shipping Address :",
                style: GoogleFonts.varela(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("${orderResModel.userAddress}",
                  style: TextStyle(
                      color: Colors.black, fontStyle: FontStyle.italic)),
            ),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                "Additional Information (Order Note):",
                style: GoogleFonts.varela(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("${orderResModel.additionalInformation}",
                  style: TextStyle(
                      color: Colors.black, fontStyle: FontStyle.italic)),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                "Status: ",
                style: GoogleFonts.varela(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(left: 8, right: 8),
              child: Card(
                elevation: 5,
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.3,
                        indicatorStyle: IndicatorStyle(
                          width: 25,
                          color: Colors.red,
                          iconStyle: IconStyle(
                              iconData: Icons.shopping_cart,
                              color: Colors.white),
                        ),
                        startChild: Text('Start'),
                        beforeLineStyle: LineStyle(
                          color: Colors.red,
                          thickness: orderResModel.orderStatus! >= 0 ? 5 : 1,
                        ),
                        afterLineStyle: LineStyle(
                          color: Colors.red,
                          thickness: orderResModel.orderStatus! >= 0 ? 5 : 1,
                        ),
                        endChild: Container(
                          margin: EdgeInsets.only(bottom: 12.0, left: 10),
                          decoration: BoxDecoration(
                            color: orderResModel.orderStatus == 0
                                ? Colors.green.withOpacity(.5)
                                : Colors.white70,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 12.0),
                          child: Text('Pending',
                              style: TextStyle(
                                  color: orderResModel.orderStatus == 0
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                      ),
                      TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.3,
                        indicatorStyle: IndicatorStyle(
                          width: 25,
                          color: Colors.red,
                          iconStyle: IconStyle(
                              iconData: Icons.shopping_cart,
                              color: Colors.white),
                        ),
                        startChild: Text(''),
                        beforeLineStyle: LineStyle(
                          color: Colors.red,
                          thickness: orderResModel.orderStatus! >= 1 ? 5 : 1,
                        ),
                        afterLineStyle: LineStyle(
                          color: Colors.red,
                          thickness: orderResModel.orderStatus! >= 1 ? 5 : 1,
                        ),
                        endChild: Container(
                          margin: EdgeInsets.only(bottom: 12.0, left: 10),
                          decoration: BoxDecoration(
                            color: orderResModel.orderStatus == 2
                                ? AppColors.red
                                : Colors.white70,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 12.0),
                          child: Text('Order Cancel',
                              style: TextStyle(
                                  color: orderResModel.orderStatus == 2
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                      ),
                      TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.3,
                        indicatorStyle: IndicatorStyle(
                          width: 25,
                          color: Colors.red,
                          iconStyle: IconStyle(
                              iconData: Icons.shopping_cart,
                              color: Colors.white),
                        ),
                        startChild: Text(''),
                        beforeLineStyle: LineStyle(
                          color: Colors.red,
                          thickness: orderResModel.orderStatus! >= 2 ? 5 : 1,
                        ),
                        afterLineStyle: LineStyle(
                          color: Colors.red,
                          thickness: orderResModel.orderStatus! >= 2 ? 5 : 1,
                        ),
                        endChild: Container(
                          margin: EdgeInsets.only(bottom: 12.0, left: 10),
                          decoration: BoxDecoration(
                            color: orderResModel.orderStatus == 1
                                ? Colors.green.withOpacity(.5)
                                : Colors.white70,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 12.0),
                          child: Text('Order Accept',
                              style: TextStyle(
                                  color: orderResModel.orderStatus == 1
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                      ),
                      TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.3,
                        indicatorStyle: IndicatorStyle(
                          width: 25,
                          color: Colors.red,
                          iconStyle: IconStyle(
                              iconData: Icons.shopping_cart,
                              color: Colors.white),
                        ),
                        startChild: Text('End'),
                        beforeLineStyle: LineStyle(
                          color: Colors.red,
                          thickness: orderResModel.orderStatus! >= 3 ? 5 : 1,
                        ),
                        endChild: Container(
                          margin: EdgeInsets.only(bottom: 12.0, left: 10),
                          decoration: BoxDecoration(
                            color: orderResModel.orderStatus! > 2
                                ? Colors.green.withOpacity(.5)
                                : Colors.white70,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 12.0),
                          child: Text(
                            'Order Delivered',
                            style: TextStyle(
                                color: orderResModel.orderStatus! > 2
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]))
        ],
      ),
    );
  }
}
