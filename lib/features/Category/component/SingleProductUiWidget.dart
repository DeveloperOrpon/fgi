import 'dart:async';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/Dialog/Authentication_Message.dart';
import 'package:fgi_y2j/features/shopping_cart/screen/CartScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config.dart';
import '../../common_component/Screen/PreviewFullScreenImages.dart';
import '../../notification/screen/NotificationScreen.dart';

class SingleProductUiWidget extends StatefulWidget {
  final int index;
  const SingleProductUiWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<SingleProductUiWidget> createState() => _SingleProductUiWidgetState();
}

class _SingleProductUiWidgetState extends State<SingleProductUiWidget> {
  int countProduct = 1;
  Timer? _timer;
  bool _longPressCanceled = false;

  void _increaseAge() {
    setState(() {
      countProduct++;
    });
  }

  void _cancelIncrease() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _longPressCanceled = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),
      padding: const EdgeInsets.all(4),
      height: 150,
      width: Get.width * .4,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 2,
              spreadRadius: 2,
              offset: const Offset(2, 2),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 100,
              aspectRatio: 2.0,
              viewportFraction:.4,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
            items: [1,2,3,4,5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return InkWell(
                    onTap: () {
                      Get.to( PreviewFullScreenImages(index: i),transition: Transition.leftToRightWithFade);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          "assets/demo/demo1.png",
                          height: 110,
                          fit: BoxFit.cover,
                          width: Get.width * .4 - 4,
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 5),
          Text(
            "Double Patty Burger",
            style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            "Double Patty Burger Double Patty Burger Double Patty Burger",
            style: GoogleFonts.roboto(color: Colors.black26, fontSize: 13),
          ),
          const SizedBox(height: 5),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              textAlign: TextAlign.left,
              "122.00 $currencySymbol",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 38,
                        width: 45,
                        child: ElevatedButton(
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ))),
                            onPressed: () {
                              if (countProduct.isGreaterThan(0)) {
                                setState(() {
                                  countProduct--;
                                });
                              }
                            },
                            child: Icon(CupertinoIcons.minus)),
                      ),
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.center,
                          "$countProduct",
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onLongPressEnd: (details) {
                          _cancelIncrease();
                        },
                        onLongPress: () {
                          Future.delayed(Duration(milliseconds: 300), () {
                            if (!_longPressCanceled) {
                              _timer = Timer.periodic(Duration(milliseconds: 150),
                                      (timer) {
                                    _increaseAge();
                                  });
                            }
                          });
                        },
                        onTap: () {

                        },
                        child: SizedBox(
                          height: 38,
                          width: 45,
                          child: ElevatedButton(
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ))),
                              onFocusChange: (value) {
                                log("onFocusChange : $value");
                              },
                              onPressed: () {
                                setState(() {
                                  countProduct++;
                                });
                              },

                              child: Icon(CupertinoIcons.plus)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 40,
                width: 50,
                child: Center(
                  child: ElevatedButton(
                      style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ))),
                      onPressed: () {

                      },
                      child: const Icon(CupertinoIcons.heart,color: Colors.black,)),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 40,
                width: 50,
                child: Center(
                  child: ElevatedButton(
                      style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ))),
                      onPressed: () {

                      },
                      child: const Icon(CupertinoIcons.bookmark,color: Colors.black,)),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        showSuccessDialogInTop("Information", "Product Added In Cart", context);
                      }, child: const Text("Add To Cart")),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Get.to(const CartScreen(),transition: Transition.upToDown);
                      }, child: const Text("Buy Now")),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}