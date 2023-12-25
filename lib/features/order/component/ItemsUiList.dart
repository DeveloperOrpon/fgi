import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/features/invoice/helper/FileSaveHelper.dart';
import 'package:fgi_y2j/features/invoice/screen/InvoicesScreen.dart';
import 'package:fgi_y2j/features/order/component/OrderDetailsScreen.dart';
import 'package:fgi_y2j/features/shopping_cart/model/OrderRes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../config/config.dart';
import '../../../config/style/app_colors.dart';
import '../../invoice/screen/InvoiceScreenPreview.dart';

class OrderItemsUI extends StatelessWidget {
  final OrderResModel orderResModel;
  final Color color;

  const OrderItemsUI(
      {super.key, required this.orderResModel, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(OrderDetailsScreen(orderResModel: orderResModel),transition: Transition.downToUp);
      },
      child: Container(
        margin: EdgeInsets.all(6),
        height: 220,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.green.shade100,
              width: .5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(3, 3),
                spreadRadius: 2,
                blurRadius: 2,
              )
            ]),
        child: Card(
          margin: EdgeInsets.all(6),
          child: Column(
            children: [
              Container(
                height: 90,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Hero(
                        tag: "${orderResModel.items![0].sId}",
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            height: 110,
                            fit: BoxFit.cover,
                            width: Get.width * .2,
                            imageUrl: orderResModel.items![0].productImage != null
                                ? orderResModel.items![0].productImage
                                : "",
                            errorWidget: (context, url, error) => Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.primary, width: .5)),
                              child: Center(
                                child: Text(
                                  "$appName",
                                  style: TextStyle(color: Colors.grey.shade200),
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
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Order No #${orderResModel.sId!.substring(0, 6)}",
                              style: GoogleFonts.robotoMono(
                                  color: Colors.black54, fontSize: 14)),
                          RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: orderResModel.items![0].productName ?? "",
                                  style: GoogleFonts.robotoMono(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: orderResModel.items!.length > 1
                                      ? "\nMore Product.."
                                      : "",
                                  style: GoogleFonts.robotoMono(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  )),
                            ]),
                          ),
                          Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            orderResModel.userAddress ?? "",
                            style: GoogleFonts.robotoMono(
                                color: Colors.black, fontSize: 12),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                          text: " Pickup :",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " ${orderResModel.pickupTime}",
                          style: TextStyle(color: Colors.black, fontSize: 13)),
                    ]),
                  )
                ],
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: " Order Date :",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              " ${DateFormat('dd MMM, yyyy').format(DateTime.parse(orderResModel.createdAt!))}",
                          style: TextStyle(color: Colors.black)),
                    ]),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: Container(

                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(
                         8)
                      ),
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Total"),
                        Text("${orderResModel.totalCost}$currencySymbol",
                            style: GoogleFonts.robotoMono(
                              color: AppColors.red,
                            )),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Qty"),
                        Text("${orderResModel.items!.length}",
                            style: GoogleFonts.robotoMono(
                              color: Colors.black,
                            )),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Status"),
                        Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          "${statusGet(orderResModel.orderStatus!)}",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Invoice"),
                        InkWell(
                          onTap: () {
                            Get.to(   InvoiceScreenPreview(
                                orderResModel: orderResModel),
                                transition: Transition.fadeIn);
                          },
                          child: Icon(CupertinoIcons.printer_fill),
                        ).animate(onPlay: (controller) => controller.repeat(reverse: true),).shake(duration: Duration(seconds: 2),delay: Duration(seconds: 5),hz: 5),
                      ],
                    )),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    ).animate().flipV();
  }
}
