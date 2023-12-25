import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/features/view_products/Model/ProductRes.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config.dart';
import '../../../config/style/app_colors.dart';
import '../../Dialog/Authentication_Message.dart';
import '../../product_details/details_screen.dart';
import '../Model/Product.dart';
import 'SingleProductListUI.dart';

class SingleProductUi extends StatefulWidget {
  final ProductModel productModel;

  const SingleProductUi({Key? key, required this.productModel})
      : super(key: key);

  @override
  State<SingleProductUi> createState() => _SingleProductUiState();
}

class _SingleProductUiState extends State<SingleProductUi> {
  double countProduct = 1;
  Timer? _timer;
  bool _longPressCanceled = false;

  void _increaseAge() {
    setState(() {
      if(widget.productModel.unitFlag!.toInt()==0){
        countProduct=countProduct+.5;
      }else{
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

  final allProductController = Get.put(AllProductController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
            ProductDetailsScreen(
              productModel: widget.productModel,
            ),
            transition: Transition.fadeIn);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        height: 280,
        width: Get.width * .4,
        decoration: BoxDecoration(
            color: Colors.white,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2.0,right: 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 110,
                      fit: BoxFit.cover,
                      width: Get.width * .45 - 4,
                        imageUrl: widget.productModel.productImage!=null ?widget.productModel.productImage!:
                        widget.productModel.fetImage==null || widget.productModel.fetImage!.isEmpty?"":widget.productModel.fetImage![0] ??
                            "",
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
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
               if(widget.productModel.discount!>0) Container(
                  width: 44,
                  padding: EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  child: Text(
                    textAlign: TextAlign.center,
                    "-${widget.productModel.discount}%",
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ),

              ],
            ),
            SizedBox(height: 5),
            Text(
              "${widget.productModel.name}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(1),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: Text(
                      "Category",
                      style: GoogleFonts.robotoMono(
                        fontSize: 9,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text("${widget.productModel.categoryName}",
                      style: GoogleFonts.robotoMono(
                        fontSize: 9,
                      )),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(1),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: Text(
                      "Company",
                      style: GoogleFonts.robotoMono(
                        fontSize: 9,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text("${widget.productModel.brandName}",
                      style: GoogleFonts.robotoMono(
                        fontSize: 9,
                      )),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(1),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: Text(
                      "Unit",
                      style: GoogleFonts.robotoMono(
                        fontSize: 9,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text("${widget.productModel.productUnitType}",
                      style: GoogleFonts.robotoMono(
                        fontSize: 9,
                      )),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                if(widget.productModel.discount!>0)  Text(
                  "$currencySymbol ${widget.productModel.price}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 14,
                    color: Colors.grey,
                    // decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  "  $currencySymbol ${productRegularPrice(widget.productModel.price.toString(), widget.productModel.discount.toString())}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
            Spacer(),
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
                          if ( widget.productModel.productUnitValue!> 1?countProduct.isGreaterThan(.5):countProduct.isGreaterThan(1)) {
                            setState(() {
                              if(widget.productModel.productUnitValue!> 1){
                                countProduct=countProduct-.5;
                              }else{
                                countProduct--;
                              }
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
                              if(widget.productModel.productUnitValue!> 1){
                                countProduct=countProduct+.5;
                              }else{
                                countProduct++;
                              }
                            });
                          },
                          child: Icon(CupertinoIcons.plus)),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          showSuccessToastTop(
                              "Information", "Product Added To cart", context);
                          allProductController.addToCartProduct(
                              widget.productModel,
                              quantity: countProduct);
                        },
                        child: Text("Add To Cart")),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
