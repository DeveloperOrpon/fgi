import 'dart:async';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/shopping_cart/model/CartRes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config.dart';
import '../../dashboard/Component/dashboardHome.dart';
import '../../view_products/component/SingleProductListUI.dart';
import '../controller/cartController.dart';
import '../model/CartRes.dart';
import '../model/CartRes.dart';

class CartProductUi extends StatefulWidget {
  final CartModel cartModel;
  final int index;

  const CartProductUi({Key? key, required this.cartModel, required this.index})
      : super(key: key);

  @override
  State<CartProductUi> createState() => _CartProductUiState();
}

class _CartProductUiState extends State<CartProductUi> {
  final cartController = Get.put(CartController());
  bool isCheck = true;
  num countProduct = 1;
  Timer? _timer;
  bool _longPressCanceled = false;



  void _increaseAge() {
    setState(() {
      if (widget.cartModel.productUnitValue!> 1) {
        countProduct = countProduct + .5;
      } else {
        countProduct++;
      }
    });
  }

  void _cancelIncrease() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _longPressCanceled = true;
  }

  @override
  void initState() {
    countProduct = (widget.cartModel.quantity ?? 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          height: 250,
          width: Get.width * .5,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: Offset(2, 2),
                )
              ]),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                            height: 110,
                            fit: BoxFit.cover,
                            width: Get.width * .5 - 20,
                            imageUrl: widget.cartModel.productImage ?? "",
                            errorWidget: (context, url, error) => Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.primary, width: .5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    appName,
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 14),
                                  ),
                                ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    const SpinKitFoldingCube(
                                      color: AppColors.primary,
                                      size: 50.0,
                                    ))),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.left,
                      "${widget.cartModel.productName}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                          color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    textAlign: TextAlign.left,
                    "Price:",
                    style:
                        GoogleFonts.roboto(color: Colors.black, fontSize: 12),
                  ),Text(
                    textAlign: TextAlign.left,
                    " ${widget.cartModel.afterDiscount} $currencySymbol",
                    style:
                        GoogleFonts.roboto(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ), Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    textAlign: TextAlign.left,
                    "Quantity:",
                    style:
                        GoogleFonts.roboto(color: Colors.black, fontSize: 12),
                  ),Text(
                    textAlign: TextAlign.left,
                    " ${widget.cartModel.quantity} (${widget.cartModel.productUnitType}-${widget.cartModel.productUnitValue??""})",
                    style:
                        GoogleFonts.roboto(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Total :",style: GoogleFonts.robotoMono(
                        fontSize: 14,
                        color: AppColors.red
                      ),),
                      // if (widget.cartModel.discount != null &&
                      //     widget.cartModel.discount! > 0)
                      //   Text(
                      //     "$currencySymbol ${widget.cartModel.price!*widget.cartModel.quantity!}",
                      //     style: const TextStyle(
                      //       fontWeight: FontWeight.w500,
                      //       decoration: TextDecoration.lineThrough,
                      //       fontSize: 14,
                      //       color: Colors.grey,
                      //       // decoration: TextDecoration.lineThrough,
                      //     ),
                      //   ),
                      Text(
                          widget.cartModel.afterDiscount==null?"": " ${widget.cartModel.afterDiscount!.toInt()*(countProduct==0?widget.cartModel.quantity!:countProduct)} $currencySymbol ",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
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
                            if ( widget.cartModel.productUnitValue!> 1?countProduct.isGreaterThan(.5):countProduct.isGreaterThan(1)) {
                              setState(() {
                                if(widget.cartModel.productUnitValue!> 1) {
                                  countProduct = countProduct - .5;
                                } else {
                                  countProduct--;
                                }
                                _updateCart();
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
                            _timer = Timer.periodic(
                                Duration(milliseconds: 150), (timer) {
                              _increaseAge();
                            });
                          }
                        });
                      },
                      onTap: () {},
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
                                cartController.startIncrease.value=true;
                                if (widget.cartModel.productUnitValue!> 1) {
                                  countProduct = countProduct + .5;
                                } else {
                                  countProduct++;
                                }
                                _updateCart();
                              });
                            },
                            child: const Icon(CupertinoIcons.plus)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 5,
          top: 5,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.blackLight,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: CupertinoCheckbox(
              activeColor: AppColors.primary,
              side: const BorderSide(color: Colors.white, width: 2),
              value: widget.cartModel.isCheck,
              onChanged: (value) {
                setState(() {
                  widget.cartModel.isCheck = value!;
                  cartController.cartItems.value[widget.index].isCheck =
                      value;
                });
              },
            ),
          ),
        ),
        Positioned(
          right: 5,
          top: 5,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )),
            child: IconButton(
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  cartController.removeProductFromCart(widget.cartModel);
                },
                icon: const Icon(
                  CupertinoIcons.delete_solid,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    ).animate().blurXY(end: 0,begin: 10,duration: Duration(milliseconds: 400));
  }

  RestartableTimer? timer;
  static const timeout = Duration(milliseconds: 1500);

  _updateCart() {
    if (timer == null) {
      timer = RestartableTimer(timeout, () {
        log("onFocusChange : $countProduct");
        cartController.cartProductCountChange(widget.cartModel, countProduct).then((value){
          setState(() {
            cartController.startIncrease.value=false;
          });
        });
      });
    } else {
      timer?.reset();
    }
  }
}
