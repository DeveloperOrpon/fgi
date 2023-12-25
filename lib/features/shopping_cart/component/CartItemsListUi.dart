import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/Dialog/Authentication_Message.dart';
import 'package:fgi_y2j/features/product_details/details_screen.dart';
import 'package:fgi_y2j/features/shopping_cart/model/CartRes.dart';
import 'package:fgi_y2j/features/view_products/Model/Product.dart';
import 'package:fgi_y2j/features/view_products/Model/ProductRes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config.dart';
import '../../../constants/var_const.dart';
import '../controller/cartController.dart';

class CartItemListUi extends StatefulWidget {
  final CartModel cartModel;
  final int index;
  const CartItemListUi({super.key, required this.cartModel, required this.index});

  @override
  State<CartItemListUi> createState() => _CartItemListUiState();
}

class _CartItemListUiState extends State<CartItemListUi> {
  final cartController = Get.put(CartController());
  bool isCheck = true;
  num countProduct = 1;
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
  void initState() {
    countProduct = (widget.cartModel.quantity ?? 1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BounceInDown(
      delay: (150+(widget.index*50)).ms,
      child: Stack  (
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                cartController.cartItems.value[widget.index].isCheck = !  cartController.cartItems.value[widget.index].isCheck;
              });
            },
            child: Container(
              height: 100,
              width: Get.width,
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.primary,width: .5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      spreadRadius: 2,
                      offset: const Offset(1, 3),
                      blurRadius: 2,
                    )
                  ]),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              width: 100,
                              fit: BoxFit.fill,
                              imageUrl: widget.cartModel.productImage??"",
                              errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(color: AppColors.primary, width: .5)),
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
                      )
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.cartModel.productName}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                            GoogleFonts.roboto(color: Colors.black, fontSize: 16),
                          ),

                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 4,bottom: 4),
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Center(
                                    child: Text("Quantity: ${widget.cartModel.quantity} (${widget.cartModel.productUnitType})",style: GoogleFonts.robotoMono(
                                      fontSize: 13,
                                    ),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              if (widget.cartModel.discount != null &&
                                  widget.cartModel.discount! > 0)
                                Text(
                                  "$currencySymbol ${widget.cartModel.price!*widget.cartModel.quantity!}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 14,
                                    color: Colors.grey,
                                    // decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              Text(
                                "$currencySymbol ${widget.cartModel.afterDiscount! * widget.cartModel.quantity!}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.pink,
                                  // decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              // Text(
                              //   "  $currencySymbol 1000 X1",
                              //   style: const TextStyle(
                              //     fontWeight: FontWeight.w500,
                              //     fontSize: 16,
                              //     color: AppColors.black,
                              //   ),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 5),
                        ],
                      )),
                  CupertinoCheckbox(
                    activeColor: AppColors.primary,
                    side: const BorderSide(color: Colors.white, width: 2),
                    value: widget.cartModel.isCheck,
                    onChanged: (value) {
                      setState(() {
                        widget.cartModel.isCheck = value!;
                        cartController.cartItems.value[widget.index].isCheck=value;
                      });
                    },
                  ) ,
                  SizedBox(width: 10,)
                ],
              ),
            ),
          ),

          Positioned(
            right: -5,
            top: -5,
            child: IconButton(
                onPressed: () {

                  cartController.removeProductFromCart(widget.cartModel);
                },
                icon: const Icon(
                  CupertinoIcons.delete_solid,
                  color: Colors.redAccent,
                )),
          ),
        ],
      ),
    );
  }
}
